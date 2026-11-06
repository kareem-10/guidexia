import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/features/profile/view_model/cubit/profile_cubit.dart';
import 'package:tourist_app/features/profile/view_model/cubit/profile_state.dart';

void showNotifications(BuildContext context, ProfileState state) {
  final profileCubit = context.read<ProfileCubit>();

  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    builder: (_) => BlocProvider.value(
      value: profileCubit,
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, current) => Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Notifications',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SwitchListTile(
                title: const Text('Trip updates'),
                value: current.tripNotifications,
                onChanged: context.read<ProfileCubit>().toggleTripNotifications,
              ),
              SwitchListTile(
                title: const Text('Review reminders'),
                value: current.reviewNotifications,
                onChanged: context
                    .read<ProfileCubit>()
                    .toggleReviewNotifications,
              ),
              SwitchListTile(
                title: const Text('App notifications'),
                value: current.appNotifications,
                onChanged: context.read<ProfileCubit>().toggleAppNotifications,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

