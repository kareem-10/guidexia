import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/features/place_details/view_model/cubit/place_details_cubit.dart';
import 'package:tourist_app/features/place_details/view_model/cubit/place_details_state.dart';

class ActivitiesSection extends StatelessWidget {
  final int placeId;

  const ActivitiesSection({super.key, required this.placeId});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Activities',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: scheme.onSurface,
          ),
        ),
        SizedBox(height: 10.h),
        BlocBuilder<PlaceDetailsCubit, PlaceDetailsState>(
          builder: (context, state) {
            if (state is ActivitiesLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Image(image: AssetImage('assets/images/loading.gif')),
                ),
              );
            }

            if (state is ActivitiesFailure) {
              return Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.cloud_off_outlined,
                      size: 30.sp,
                      color: scheme.onSurfaceVariant,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Could not load activities.',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: scheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<PlaceDetailsCubit>().getActivities(
                          placeId,
                        );
                      },
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              );
            }

            if (state is ActivitiesSuccess) {
              if (state.activities.isEmpty) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(18.w),
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Text(
                    'No activities available for this place.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                );
              }

              return Column(
                children: state.activities.map((activity) {
                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 10.h),
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: scheme.surface,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                activity.name,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: scheme.onSurface,
                                ),
                              ),
                            ),
                            if (activity.badge != null &&
                                activity.badge!.trim().isNotEmpty) ...[
                              SizedBox(width: 8.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 9.w,
                                  vertical: 5.h,
                                ),
                                decoration: BoxDecoration(
                                  color: scheme.primary.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  activity.badge!,
                                  style: TextStyle(
                                    fontSize: 9.sp,
                                    color: scheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        if (activity.description.isNotEmpty) ...[
                          SizedBox(height: 7.h),
                          Text(
                            activity.description,
                            style: TextStyle(
                              fontSize: 11.sp,
                              height: 1.5,
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 15.sp,
                              color: scheme.primary,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              _formatDuration(activity.durationInMinutes),
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              activity.price <= 0
                                  ? 'Free'
                                  : '${activity.price.toStringAsFixed(0)} EGP',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: scheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  String _formatDuration(int minutes) {
    if (minutes <= 0) return 'Duration not specified';

    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;

    if (hours == 0) return '$minutes min';
    if (remainingMinutes == 0) return '$hours hr';

    return '$hours hr $remainingMinutes min';
  }
}
