import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/features/auth/view/signup_view/widgets/role_card.dart';
import 'package:tourist_app/features/auth/view_model/signup_cubit/signup_cubit.dart';
import 'package:tourist_app/features/auth/view_model/signup_cubit/signup_state.dart';

class RoleSelector extends StatelessWidget {
  const RoleSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();

    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: RoleCard(
                title: 'Tourist',
                subtitle: 'Explore places',
                icon: Icons.explore_outlined,
                selected: cubit.selectedRole == 'Tourist',
                onTap: () => cubit.selectRole('Tourist'),
              ),
            ),
            horizontalSpace(12),
            Expanded(
              child: RoleCard(
                title: 'Tour Guide',
                subtitle: 'Guide travelers',
                icon: Icons.tour_outlined,
                selected: cubit.selectedRole == 'TourGuide',
                onTap: () => cubit.selectRole('TourGuide'),
              ),
            ),
          ],
        );
      },
    );
  }
}
