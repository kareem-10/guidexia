import 'package:flutter/material.dart';
import 'package:tourist_app/core/utils/app_colors.dart';
import '../../data/models/profile_model.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileModel profile;
  final VoidCallback onEdit;

  const ProfileHeader({super.key, required this.profile, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE7E7DF)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 31,
            backgroundColor: const Color(0xFFE7EDE4),
            backgroundImage: profile.imageUrl == null
                ? null
                : NetworkImage(profile.imageUrl!),
            child: profile.imageUrl == null
                ? Icon(
                    Icons.person_rounded,
                    color: AppColors.primaryColor,
                    size: 32,
                  )
                : null,
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name,
                  style: const TextStyle(
                    color: Color(0xFF252820),
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${profile.city}, ${profile.country}',
                  style: const TextStyle(
                    color: Color(0xFF77796F),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  profile.role.toUpperCase(),
                  style: TextStyle(
                    color: AppColors.primaryColor,
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
            icon: Icon(Icons.edit_outlined, color: AppColors.primaryColor),
            tooltip: 'Edit profile',
          ),
        ],
      ),
    );
  }
}
