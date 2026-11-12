import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class GuideNavBarWidget extends StatelessWidget {
  const GuideNavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final primary = Theme.of(context).colorScheme.primary;

    return PersistentTabView(
      tabs: [
        PersistentTabConfig(
          screen: GuidePlaceholderScreen(
            title: 'Dashboard',
            subtitle: 'Your guide dashboard will be available here.',
            icon: Icons.dashboard_outlined,
          ),
          item: ItemConfig(
            icon: Icon(Icons.dashboard_outlined),
            title: 'Dashboard',
          ),
        ),
        PersistentTabConfig(
          screen: GuidePlaceholderScreen(
            title: 'My Places',
            subtitle: 'Manage your listed places here.',
            icon: Icons.place_outlined,
          ),
          item: ItemConfig(
            icon: Icon(Icons.place_outlined),
            title: 'My Places',
          ),
        ),
        PersistentTabConfig(
          screen: GuidePlaceholderScreen(
            title: 'Requests',
            subtitle: 'Your tourist requests will appear here.',
            icon: Icons.assignment_outlined,
          ),
          item: ItemConfig(
            icon: Icon(Icons.assignment_outlined),
            title: 'Requests',
          ),
        ),
        PersistentTabConfig(
          screen: GuidePlaceholderScreen(
            title: 'Profile',
            subtitle: 'Manage your guide profile here.',
            icon: Icons.person_outline,
          ),
          item: ItemConfig(icon: Icon(Icons.person_outline), title: 'Profile'),
        ),
      ],
      navBarBuilder: (navBarConfig) => Style6BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}

class GuidePlaceholderScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const GuidePlaceholderScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: false),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 64, color: theme.colorScheme.primary),
              const SizedBox(height: 20),
              Text(
                title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 20),
              const Chip(label: Text('Coming soon')),
            ],
          ),
        ),
      ),
    );
  }
}
