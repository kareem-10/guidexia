import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/core/utils/app_colors.dart';
import 'package:tourist_app/features/profile/view_model/cubit/profile_cubit.dart';
import 'package:tourist_app/features/profile/view_model/cubit/profile_state.dart';

void showSettings(BuildContext context, ProfileState state) {
  final profileCubit = context.read<ProfileCubit>();

  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    backgroundColor: Colors.white,
    builder: (_) => BlocProvider.value(
      value: profileCubit,
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, current) => Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Settings',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: Icon(
                  Icons.palette_outlined,
                  color: AppColors.primaryColor,
                ),
                title: const Text('Appearance'),
                subtitle: Text(current.isDarkMode ? 'Dark mode' : 'Light mode'),
                trailing: Switch(
                  value: current.isDarkMode,
                  activeThumbColor: AppColors.primaryColor,
                  onChanged: context.read<ProfileCubit>().toggleTheme,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 56),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Preview only — connect this control to your app ThemeMode later.',
                    style: TextStyle(color: Color(0xFF77796F), fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: Icon(
                  Icons.language_outlined,
                  color: AppColors.primaryColor,
                ),
                title: const Text('Language'),
                subtitle: const Text('English'),
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
              ListTile(
                leading: Icon(
                  Icons.privacy_tip_outlined,
                  color: AppColors.primaryColor,
                ),
                title: const Text('Privacy'),
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
