import 'package:flutter/material.dart';
import 'package:tourist_app/core/utils/app_colors.dart';

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
    final color = destructive
        ? const Color(0xFFC85D49)
        : AppColors.primaryColor;
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: destructive
              ? const Color(0xFFFCEDEA)
              : const Color(0xFFF1F4EC),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: destructive ? color : const Color(0xFF252820),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing:
          trailing ??
          const Icon(Icons.chevron_right_rounded, color: Color(0xFF8B8D84)),
      minLeadingWidth: 0,
    );
  }
}
