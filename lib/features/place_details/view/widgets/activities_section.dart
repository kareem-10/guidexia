import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/features/place_details/view/widgets/details_section_title.dart';
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
        const DetailsSectionTitle(
          title: 'Things to do',
          subtitle: 'Explore experiences available at this destination.',
        ),

        verticalSpace(15),

        BlocBuilder<PlaceDetailsCubit, PlaceDetailsState>(
          builder: (context, state) {
            if (state is ActivitiesLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: Image(image: AssetImage('assets/images/loading.gif')),
                ),
              );
            }

            if (state is ActivitiesFailure) {
              return _ActivitiesMessage(
                icon: Icons.cloud_off_outlined,
                message: 'Could not load activities.',
                scheme: scheme,
                child: TextButton(
                  onPressed: () {
                    context.read<PlaceDetailsCubit>().getActivities(placeId);
                  },
                  child: const Text('Try again'),
                ),
              );
            }

            if (state is ActivitiesSuccess) {
              if (state.activities.isEmpty) {
                return _ActivitiesMessage(
                  icon: Icons.explore_outlined,
                  message: 'No activities available for this place.',
                  scheme: scheme,
                );
              }

              return Column(
                children: state.activities.map((activity) {
                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.all(15.w),
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(19.r),
                      border: Border.all(
                        color: scheme.outlineVariant.withValues(alpha: 0.4),
                      ),
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
                                  color: scheme.onSurface,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),

                            if (activity.badge != null &&
                                activity.badge!.trim().isNotEmpty) ...[
                              horizontalSpace(8),
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
                                    color: scheme.primary,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),

                        if (activity.description.isNotEmpty) ...[
                          verticalSpace(8),
                          Text(
                            activity.description,
                            style: TextStyle(
                              color: scheme.onSurfaceVariant,
                              fontSize: 11.sp,
                              height: 1.6,
                            ),
                          ),
                        ],

                        verticalSpace(14),

                        Divider(
                          color: scheme.outlineVariant.withValues(alpha: 0.5),
                          height: 1,
                        ),

                        verticalSpace(12),

                        Row(
                          children: [
                            Icon(
                              Icons.schedule_rounded,
                              color: scheme.primary,
                              size: 16.sp,
                            ),
                            horizontalSpace(5),
                            Text(
                              _formatDuration(activity.durationInMinutes),
                              style: TextStyle(
                                color: scheme.onSurfaceVariant,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            const Spacer(),

                            Text(
                              activity.price <= 0
                                  ? 'Free'
                                  : '${activity.price.toStringAsFixed(0)} EGP',
                              style: TextStyle(
                                color: scheme.primary,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800,
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

class _ActivitiesMessage extends StatelessWidget {
  final IconData icon;
  final String message;
  final ColorScheme scheme;
  final Widget? child;

  const _ActivitiesMessage({
    required this.icon,
    required this.message,
    required this.scheme,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        children: [
          Icon(icon, size: 30.sp, color: scheme.onSurfaceVariant),
          verticalSpace(10),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12.sp),
          ),
          if (child != null) ...[verticalSpace(5), child!],
        ],
      ),
    );
  }
}
