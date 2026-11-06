import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/core/theming/theme_cubit/theme_cubit.dart';
import 'package:tourist_app/core/theming/theme_cubit/theme_state.dart';
import 'package:tourist_app/features/profile/view_model/cubit/profile_cubit.dart';
import 'package:tourist_app/features/profile/view_model/cubit/profile_state.dart';

void showSettings(BuildContext context, ProfileState state) {
  final profileCubit = context.read<ProfileCubit>();
  final themeCubit = context.read<ThemeCubit>();

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    elevation: 0,
    builder: (_) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: profileCubit),
        BlocProvider.value(value: themeCubit),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return Material(
            // put color here to make change in the sheet when click on the icon
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 32,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Settings',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      leading: Icon(
                        Icons.palette_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: const Text('Appearance'),
                      subtitle: Text(
                        themeState.themeMode == ThemeMode.dark
                            ? 'Dark mode'
                            : 'Light mode',
                      ),
                      trailing: Switch(
                        value: themeState.themeMode == ThemeMode.dark,
                        onChanged: context.read<ThemeCubit>().toggleDarkMode,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      leading: Icon(
                        Icons.language_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: const Text('Language'),
                      subtitle: const Text('English'),
                      trailing: const Icon(Icons.chevron_right_rounded),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.privacy_tip_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: const Text('Privacy'),
                      trailing: const Icon(Icons.chevron_right_rounded),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
