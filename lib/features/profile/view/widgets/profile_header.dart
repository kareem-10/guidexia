import 'package:flutter/material.dart';
import '../../data/models/profile_model.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileModel profile;
  final VoidCallback onEdit;

  const ProfileHeader({super.key, required this.profile, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 31,
            backgroundColor: scheme.surfaceContainerHighest,
            backgroundImage: profile.imageUrl == null
                ? null
                : NetworkImage(profile.imageUrl!),
            child: profile.imageUrl == null
                ? Icon(Icons.person_rounded, color: scheme.primary, size: 32)
                : null,
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name,
                  style: textTheme.titleMedium?.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${profile.city}, ${profile.country}',
                  style: textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  profile.role.toUpperCase(),
                  style: textTheme.labelSmall?.copyWith(
                    color: scheme.primary,
                    fontSize: 10,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onEdit,
            icon: Icon(Icons.edit_outlined, color: scheme.primary),
            tooltip: 'Edit profile',
          ),
        ],
      ),
    );
  }
}

