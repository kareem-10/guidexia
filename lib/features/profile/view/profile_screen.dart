import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/core/functions/show_toast.dart';
import 'package:tourist_app/core/utils/app_colors.dart';
import 'package:tourist_app/features/profile/view_model/cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileError) {
          showToast(state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is ProfileLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                )
              : state is ProfileSuccess
              ? ListView(
                  children: [
                    const SizedBox(height: 16),
                    //! Profile Picture
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(
                        state.profileModel.profilePic,
                      ),
                    ),
                    const SizedBox(height: 16),

                    //! Name
                    ListTile(
                      title: Text(state.profileModel.name),
                      leading: const Icon(Icons.person),
                    ),
                    const SizedBox(height: 16),

                    //! Email
                    ListTile(
                      title: Text(state.profileModel.email),
                      leading: const Icon(Icons.email),
                    ),
                    const SizedBox(height: 16),

                    //! Phone number
                    ListTile(
                      title: Text(state.profileModel.phone),
                      leading: const Icon(Icons.phone),
                    ),
                    const SizedBox(height: 16),
                  ],
                )
              : Container(),
        );
      },
    );
  }
}
