import 'dart:ui'; // مهم جداً لاستيراد ImageFilter
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:tourist_app/core/di/dependancy_injection.dart';
import 'package:tourist_app/features/explore/view/explore_screen.dart';
import 'package:tourist_app/features/explore/view_model/cubit/explore_cubit.dart';
import 'package:tourist_app/features/guides/view/screens/guides_screen.dart';
import 'package:tourist_app/features/guides/view_model/cubit/guides_cubit.dart';
import 'package:tourist_app/features/profile/view/profile_screen.dart';
import 'package:tourist_app/features/profile/view_model/cubit/profile_cubit.dart';
import 'package:tourist_app/features/saved/view/saved_screen.dart';
import 'package:tourist_app/features/saved/view_model/cubit/saved_cubit.dart';
import 'package:tourist_app/features/stays/view/stays_screen.dart';
import 'package:tourist_app/features/stays/view_model/cubit/stay_cubit.dart';

class NavBarWidget extends StatelessWidget {
  const NavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => getIt<SavedCubit>()..getSaves(),
      child: PersistentTabView(
        navBarOverlap: const NavBarOverlap.full(),
        tabs: [
          PersistentTabConfig(
            screen: BlocProvider(
              create: (context) => getIt<ExploreCubit>(),
              child: const ExploreScreen(),
            ),
            item: ItemConfig(
              icon: const Icon(Icons.explore_outlined),
              activeForegroundColor: primary,
              activeColorSecondary: primary,
              title: "Explore",
            ),
          ),
          PersistentTabConfig(
            screen: BlocProvider(
              create: (context) => getIt<GuidesCubit>()..loadGuides(),
              child: const GuidesScreen(),
            ),
            item: ItemConfig(
              icon: const Icon(Icons.group_outlined),
              activeForegroundColor: primary,
              activeColorSecondary: primary,
              title: "Guides",
            ),
          ),
          PersistentTabConfig(
            screen: BlocProvider(
              create: (context) => getIt<StayCubit>()..getStays(),
              child: const StaysScreen(),
            ),
            item: ItemConfig(
              icon: const Icon(Icons.hotel_outlined),
              activeForegroundColor: primary,
              activeColorSecondary: primary,
              title: "Stays",
            ),
          ),
          PersistentTabConfig(
            screen: const SavedScreen(),
            item: ItemConfig(
              icon: const Icon(Icons.favorite_border_outlined),
              activeForegroundColor: primary,
              activeColorSecondary: primary,
              title: "Saved",
            ),
          ),
          PersistentTabConfig(
            screen: BlocProvider(
              create: (context) => getIt<ProfileCubit>(),
              child: const ProfileScreen(),
            ),
            item: ItemConfig(
              icon: const Icon(Icons.person_outlined),
              activeForegroundColor: primary,
              activeColorSecondary: primary,
              title: "Profile",
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) => Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.2)
                      : Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 1.0,
                  ),
                ),
                child: Style6BottomNavBar(
                  navBarConfig: navBarConfig,
                  navBarDecoration: const NavBarDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
