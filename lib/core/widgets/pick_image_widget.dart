import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourist_app/features/signup/view_model/cubit/signup_cubit.dart';
import 'package:tourist_app/features/signup/view_model/cubit/signup_state.dart';

class PickImageWidget extends StatelessWidget {
  const PickImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          width: 130,
          height: 130,
          child: context.read<SignupCubit>().profilePic == null
              ? CircleAvatar(
                  backgroundColor: scheme.surfaceContainerHighest,
                  backgroundImage: const AssetImage("assets/images/avatar.png"),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: () async {},
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: scheme.primary,
                              border: Border.all(
                                color: scheme.surface,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                ImagePicker()
                                    .pickImage(source: ImageSource.gallery)
                                    .then(
                                      // ignore: use_build_context_synchronously
                                      (value) => context
                                          .read<SignupCubit>()
                                          .uploadProfilePic(value!),
                                    );
                              },
                              child: Icon(
                                Icons.camera_alt_sharp,
                                color: scheme.onPrimary,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : CircleAvatar(
                  backgroundImage: FileImage(
                    File(context.read<SignupCubit>().profilePic!.path),
                  ),
                ),
        );
      },
    );
  }
}
