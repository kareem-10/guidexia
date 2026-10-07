import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:tourist_app/core/di/dependancy_injection.dart';
import 'package:tourist_app/core/utils/app_colors.dart';
import 'package:tourist_app/features/explore/view/explore_screen.dart';
import 'package:tourist_app/features/explore/view_model/cubit/explore_cubit.dart';
import 'package:tourist_app/features/guides/view/guides_screen.dart';
import 'package:tourist_app/features/profile/view/profile_screen.dart';
import 'package:tourist_app/features/profile/view_model/cubit/profile_cubit.dart';
import 'package:tourist_app/features/saved/view/saved_screen.dart';
import 'package:tourist_app/features/stays/view/stays_screen.dart';

class NavBarWidget extends StatelessWidget {
  const NavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: [
        PersistentTabConfig(
          screen: BlocProvider(
            create: (context) => getIt<ExploreCubit>(),
            child: ExploreScreen(),
          ),
          item: ItemConfig(
            icon: Icon(Icons.explore_outlined),
            activeForegroundColor: AppColors.primaryColor,
            activeColorSecondary: AppColors.primaryColor,
            title: "Explore",
          ),
        ),
        PersistentTabConfig(
          screen: GuidesScreen(),
          item: ItemConfig(
            icon: Icon(Icons.group_outlined),
            activeForegroundColor: AppColors.primaryColor,
            activeColorSecondary: AppColors.primaryColor,
            title: "Guides",
          ),
        ),
        PersistentTabConfig(
          screen: StaysScreen(),
          item: ItemConfig(
            icon: Icon(Icons.hotel_outlined),
            activeForegroundColor: AppColors.primaryColor,
            activeColorSecondary: AppColors.primaryColor,
            title: "Stays",
          ),
        ),
        PersistentTabConfig(
          screen: SavedScreen(),
          item: ItemConfig(
            icon: Icon(Icons.favorite_border_outlined),
            activeForegroundColor: AppColors.primaryColor,
            activeColorSecondary: AppColors.primaryColor,
            title: "Saved",
          ),
        ),
        PersistentTabConfig(
          screen: BlocProvider(
            create: (context) => getIt<ProfileCubit>(),
            child: ProfileScreen(),
          ),
          item: ItemConfig(
            icon: Icon(Icons.person_outlined),
            activeForegroundColor: AppColors.primaryColor,
            activeColorSecondary: AppColors.primaryColor,
            title: "Profile",
          ),
        ),
      ],
      navBarBuilder: (navBarConfig) =>
          Style6BottomNavBar(navBarConfig: navBarConfig),
    );
  }
}
