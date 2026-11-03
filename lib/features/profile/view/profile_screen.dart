import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/core/widgets/app_bar_title.dart';
import 'package:tourist_app/features/profile/view/widgets/confirm_logout.dart';
import 'package:tourist_app/features/profile/view/widgets/show_edit_profile.dart';
import 'package:tourist_app/features/profile/view/widgets/show_notifications.dart';
import 'package:tourist_app/features/profile/view/widgets/show_personal_info.dart';
import 'package:tourist_app/features/profile/view/widgets/show_reviews.dart';
import 'package:tourist_app/features/profile/view/widgets/show_settings.dart';
import 'package:tourist_app/features/profile/view/widgets/show_trip.dart';
import '../view_model/cubit/profile_cubit.dart';
import '../view_model/cubit/profile_state.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_menu_item.dart';
import 'widgets/profile_section_title.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: AppBarTitle(text: 'Profile'),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.status == ProfileStatus.loading ||
              state.status == ProfileStatus.initial) {
            return const Center(
              child: Image(image: AssetImage('assets/images/loading.gif')),
            );
          }
          if (state.status == ProfileStatus.failure || state.profile == null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Something went wrong.'),
                  TextButton(
                    onPressed: () => context.read<ProfileCubit>().loadProfile(),
                    child: const Text('Try again'),
                  ),
                ],
              ),
            );
          }

          final profile = state.profile!;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            children: [
              ProfileHeader(
                profile: profile,
                onEdit: () => showEditProfile(context, profile),
              ),
              const ProfileSectionTitle(title: 'Your account'),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFE7E7DF)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ProfileMenuItem(
                      icon: Icons.person_outline_rounded,
                      title: 'Personal information',
                      onTap: () => showPersonalInfo(context, profile),
                    ),
                    const _MenuDivider(),
                    ProfileMenuItem(
                      icon: Icons.map_outlined,
                      title: 'My Trips',
                      onTap: () => showTrips(context, state.trips),
                    ),
                    const _MenuDivider(),
                    ProfileMenuItem(
                      icon: Icons.star_border_rounded,
                      title: 'My Reviews',
                      onTap: () => showReviews(context, state.reviews),
                    ),
                    const _MenuDivider(),
                    ProfileMenuItem(
                      icon: Icons.notifications_none_rounded,
                      title: 'Notifications',
                      onTap: () => showNotifications(context, state),
                    ),
                    const _MenuDivider(),
                    ProfileMenuItem(
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      onTap: () => showSettings(context, state),
                    ),
                    const _MenuDivider(),
                    ProfileMenuItem(
                      icon: Icons.logout_rounded,
                      title: 'Logout',
                      destructive: true,
                      onTap: () => confirmLogout(context),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MenuDivider extends StatelessWidget {
  const _MenuDivider();

  @override
  Widget build(BuildContext context) => const Divider(
    height: 1,
    thickness: 1,
    color: Color(0xFFE7E7DF),
    indent: 12,
    endIndent: 12,
  );
}
