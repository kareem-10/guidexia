import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool destructive;
  final Widget? trailing;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.destructive = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = destructive ? scheme.error : scheme.primary;
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        leading: SizedBox(
          width: 38,
          height: 38,
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: destructive ? color : scheme.onSurface,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing:
            trailing ??
            Icon(Icons.chevron_right_rounded, color: scheme.onSurfaceVariant),
        minLeadingWidth: 0,
      ),
    );
  }
}
