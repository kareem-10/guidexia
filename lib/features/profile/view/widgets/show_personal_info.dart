import 'package:flutter/material.dart';
import 'package:tourist_app/core/utils/app_colors.dart';
import 'package:tourist_app/features/profile/data/models/profile_model.dart';
import 'package:tourist_app/features/profile/view/widgets/show_edit_profile.dart';

void showPersonalInfo(BuildContext context, ProfileModel p) {
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    backgroundColor: Colors.white,
    builder: (_) => Padding(
      padding: const EdgeInsets.fromLTRB(22, 8, 22, 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Personal information',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 18),
          _InfoRow(label: 'Full name', value: p.name),
          _InfoRow(label: 'Email', value: p.email),
          _InfoRow(label: 'Phone', value: p.phone),
          _InfoRow(label: 'City', value: p.city),
          _InfoRow(label: 'Country', value: p.country),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);
                showEditProfile(context, p);
              },
              child: const Text('Edit information'),
            ),
          ),
        ],
      ),
    ),
  );
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 95,
          child: Text(label, style: const TextStyle(color: Color(0xFF77796F))),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}
