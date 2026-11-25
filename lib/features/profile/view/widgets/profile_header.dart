import 'dart:io';

import 'package:flutter/material.dart';
import '../../data/models/profile_model.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileModel profile;
  final VoidCallback onEdit;
  final VoidCallback onChangePhoto;

  const ProfileHeader({
    super.key,
    required this.profile,
    required this.onEdit,
    required this.onChangePhoto,
  });

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
          GestureDetector(
            onTap: onChangePhoto,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 31,
                  backgroundColor: scheme.surfaceContainerHighest,
                  backgroundImage: profile.localImagePath != null
                      ? FileImage(File(profile.localImagePath!))
                      : (profile.imageUrl != null &&
                            profile.imageUrl!.isNotEmpty)
                      ? NetworkImage(profile.imageUrl!)
                      : null,
                  child:
                      profile.localImagePath == null &&
                          (profile.imageUrl == null ||
                              profile.imageUrl!.isEmpty)
                      ? Icon(
                          Icons.person_rounded,
                          color: scheme.primary,
                          size: 32,
                        )
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: scheme.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: scheme.surface, width: 1.5),
                    ),
                    child: Icon(
                      Icons.camera_alt_rounded,
                      size: 12,
                      color: scheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
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
                  profile.role.toUpperCase(),
                  style: textTheme.labelSmall?.copyWith(
                    color: scheme.primary,
                    fontSize: 10,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profile.location ?? '',
                  style: textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
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
