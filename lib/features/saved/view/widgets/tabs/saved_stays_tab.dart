import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/features/saved/view/widgets/saved_empty_state.dart';
import 'package:tourist_app/features/saved/view_model/cubit/saved_cubit.dart';
import 'package:tourist_app/features/saved/view_model/cubit/saved_state.dart';
import 'package:tourist_app/features/stays/view/widgets/stay_card.dart';

class SavedStaysTab extends StatelessWidget {
  const SavedStaysTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedCubit, SavedState>(
      builder: (context, state) {
        if (state is SavedInitial || state is SavedLoading) {
          return const Center(
            child: Image(image: AssetImage('assets/images/loading.gif')),
          );
        }

        if (state is SavedFailure) {
          return Center(child: Text(state.message));
        }

        if (state is! SavedSuccess) {
          return const SizedBox.shrink();
        }

        if (state.stays.isEmpty) {
          return const SavedEmptyState(
            title: 'No saved stays yet',
            subtitle: 'Save hotels and accommodations to find them here.',
          );
        }

        return ListView.separated(
          padding: EdgeInsets.all(16.w),
          separatorBuilder: (_, _) => verticalSpace(14.h),
          itemCount: state.stays.length,
          itemBuilder: (context, index) {
            final stay = state.stays[index];

            return StayCard(stay: stay);
          },
        );
      },
    );
  }
}
