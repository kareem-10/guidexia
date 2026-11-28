import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/features/explore/data/models/place_model.dart';
import 'package:tourist_app/features/place_details/view/widgets/details_section_title.dart';

class LocationSection extends StatelessWidget {
  final PlaceModel place;

  const LocationSection({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final hasCoordinates = place.latitude != null && place.longitude != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DetailsSectionTitle(
          title: 'Where is it?',
          subtitle: 'Location information for this destination.',
        ),

        verticalSpace(14),

        Container(
          padding: EdgeInsets.all(17.w),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: scheme.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 49.w,
                height: 49.w,
                decoration: BoxDecoration(
                  color: scheme.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Icon(
                  Icons.location_on_rounded,
                  color: scheme.error,
                  size: 25.sp,
                ),
              ),

              horizontalSpace(13),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${place.city}, ${place.country}',
                      style: TextStyle(
                        color: scheme.onSurface,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    if (hasCoordinates) ...[
                      verticalSpace(5),
                      Text(
                        '${place.latitude!.toStringAsFixed(4)}, '
                        '${place.longitude!.toStringAsFixed(4)}',
                        style: TextStyle(
                          color: scheme.onSurfaceVariant,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
