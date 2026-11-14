import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/core/functions/show_toast.dart';
import 'package:tourist_app/features/profile/data/models/profile_model.dart';
import 'package:tourist_app/features/profile/view_model/cubit/profile_cubit.dart';
import 'package:tourist_app/features/profile/view_model/cubit/profile_state.dart';

Future<void> showEditProfile(BuildContext context, ProfileModel profile) async {
  final profileCubit = context.read<ProfileCubit>();

  await showDialog<void>(
    context: context,
    builder: (_) => BlocProvider.value(
      value: profileCubit,
      child: EditProfileDialog(profile: profile),
    ),
  );
}

class EditProfileDialog extends StatefulWidget {
  final ProfileModel profile;

  const EditProfileDialog({super.key, required this.profile});

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late final TextEditingController firstName;
  late final TextEditingController lastName;
  late final TextEditingController email;
  late final TextEditingController phone;
  late final TextEditingController location;
  late final TextEditingController bio;

  @override
  void initState() {
    super.initState();

    firstName = TextEditingController(text: widget.profile.firstName);
    lastName = TextEditingController(text: widget.profile.lastName);
    email = TextEditingController(text: widget.profile.email);
    phone = TextEditingController(text: widget.profile.phone);
    location = TextEditingController(text: widget.profile.location);
    bio = TextEditingController(text: widget.profile.bio);
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    phone.dispose();
    location.dispose();
    bio.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    final cubit = context.read<ProfileCubit>();
    final success = await cubit.updateProfile(
      firstName: firstName.text.trim(),
      lastName: lastName.text.trim(),
      phoneNumber: phone.text.trim(),
      location: location.text.trim(),
      bio: bio.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      Navigator.pop(context);
      showToast('Profile updated successfully');
    } else {
      showToast('Could not update profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final isLoading = state.status == ProfileStatus.loading;

        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: const Text('Edit profile'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _EditField(controller: firstName, label: 'First name'),
                _EditField(controller: lastName, label: 'Last name'),
                _EditField(controller: email, label: 'Email', readOnly: true),
                _EditField(controller: phone, label: 'Phone'),
                _EditField(controller: location, label: 'Location'),
                _EditField(controller: bio, label: 'Bio', maxLines: 3),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: isLoading ? null : () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
            FilledButton(
              onPressed: isLoading ? null : _saveProfile,
              child: isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

class _EditField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool readOnly;
  final int maxLines;

  const _EditField({
    required this.controller,
    required this.label,
    this.readOnly = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextField(
      controller: controller,
      readOnly: readOnly,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
