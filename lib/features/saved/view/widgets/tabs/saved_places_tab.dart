import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/features/explore/view/widgets/place_card.dart';
import 'package:tourist_app/features/saved/view/widgets/saved_empty_state.dart';
import 'package:tourist_app/features/saved/view_model/cubit/saved_cubit.dart';
import 'package:tourist_app/features/saved/view_model/cubit/saved_state.dart';

class SavedPlacesTab extends StatelessWidget {
  const SavedPlacesTab({super.key});

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
          return Center(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.cloud_off_outlined, size: 44),
                  SizedBox(height: 12.h),
                  const Text(
                    'Could not load saved places.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                  ),
                  SizedBox(height: 16.h),
                  FilledButton(
                    onPressed: () {
                      context.read<SavedCubit>().getSaves();
                    },
                    child: const Text('Try again'),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is SavedSuccess) {
          if (state.places.isEmpty) {
            return const SavedEmptyState(
              title: 'No saved places yet',
              subtitle:
                  'Explore amazing destinations and tap the heart to save them.',
            );
          }

          return RefreshIndicator(
            onRefresh: () => context.read<SavedCubit>().getSaves(),
            child: GridView.builder(
              padding: EdgeInsets.all(16.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 14.h,
                childAspectRatio: 0.72,
              ),
              itemCount: state.places.length,
              itemBuilder: (context, index) {
                final place = state.places[index];

                return PlaceCard(place: place);
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
