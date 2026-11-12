import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/core/di/dependancy_injection.dart';
import 'package:tourist_app/core/helpers/secure_storage_helper.dart';
import 'package:tourist_app/features/auth/view/login_view/login_screen.dart';
import 'package:tourist_app/features/auth/view_model/login_cubit/login_cubit.dart';
import 'package:tourist_app/features/guide_panel/view/guide_nav_bar_widget.dart';
import 'package:tourist_app/core/widgets/nav_bar_widget.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  late Future<Widget> _authFuture;

  @override
  void initState() {
    super.initState();
    _authFuture = _checkAuth();
  }

  Future<Widget> _checkAuth() async {
    final secureStorage = getIt<SecureStorageHelper>();

    try {
      final token = await secureStorage.getToken();

      if (token == null || token.isEmpty) {
        return _buildLoginScreen();
      }

      final payload = _decodeToken(token);

      if (payload == null) {
        await secureStorage.clearAuthData();
        return _buildLoginScreen();
      }

      // Check token expiration.
      final expiration = payload['exp'];

      if (expiration is! num) {
        await secureStorage.clearAuthData();
        return _buildLoginScreen();
      }

      final expirationDate = DateTime.fromMillisecondsSinceEpoch(
        expiration.toInt() * 1000,
      );

      if (!expirationDate.isAfter(DateTime.now())) {
        await secureStorage.clearAuthData();
        return _buildLoginScreen();
      }

      // Read the user's role.
      final role =
          payload['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];

      switch (role) {
        case 'Tourist':
          return const NavBarWidget();

        case 'TourGuide':
          return const GuideNavBarWidget();

        default:
          await secureStorage.clearAuthData();
          return _buildLoginScreen();
      }
    } catch (e) {
      return _buildLoginScreen();
    }
  }

  Map<String, dynamic>? _decodeToken(String token) {
    try {
      final parts = token.split('.');

      if (parts.length != 3) return null;

      final normalizedPayload = base64Url.normalize(parts[1]);
      final decodedPayload = utf8.decode(base64Url.decode(normalizedPayload));

      return jsonDecode(decodedPayload) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  Widget _buildLoginScreen() {
    return BlocProvider(
      create: (_) => getIt<LoginCubit>(),
      child: const LoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _authFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: Image.asset('assets/images/loading.gif')),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Unable to load your account.'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _authFuture = _checkAuth();
                      });
                    },
                    child: const Text('Try again'),
                  ),
                ],
              ),
            ),
          );
        }

        return snapshot.data!;
      },
    );
  }
}
