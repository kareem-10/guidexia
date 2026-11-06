import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/core/functions/show_toast.dart';
import 'package:tourist_app/features/profile/data/models/profile_model.dart';
import 'package:tourist_app/features/profile/view_model/cubit/profile_cubit.dart';

Future<void> showEditProfile(BuildContext context, ProfileModel profile) async {
  final updated = await showDialog<ProfileModel>(
    context: context,
    builder: (_) => EditProfileDialog(profile: profile),
  );

  if (!context.mounted || updated == null) return;

  context.read<ProfileCubit>().updateProfile(updated);

  showToast('Profile updated successfully');
}

class EditProfileDialog extends StatefulWidget {
  final ProfileModel profile;

  const EditProfileDialog({super.key, required this.profile});

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late final TextEditingController name;
  late final TextEditingController email;
  late final TextEditingController phone;
  late final TextEditingController city;
  late final TextEditingController country;

  @override
  void initState() {
    super.initState();

    name = TextEditingController(text: widget.profile.name);
    email = TextEditingController(text: widget.profile.email);
    phone = TextEditingController(text: widget.profile.phone);
    city = TextEditingController(text: widget.profile.city);
    country = TextEditingController(text: widget.profile.country);
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    city.dispose();
    country.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: const Text('Edit profile'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _EditField(controller: name, label: 'Full name'),
            _EditField(controller: email, label: 'Email'),
            _EditField(controller: phone, label: 'Phone'),
            _EditField(controller: city, label: 'City'),
            _EditField(controller: country, label: 'Country'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(
              context,
              widget.profile.copyWith(
                name: name.text.trim(),
                email: email.text.trim(),
                phone: phone.text.trim(),
                city: city.text.trim(),
                country: country.text.trim(),
              ),
            );
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class _EditField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const _EditField({required this.controller, required this.label});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
