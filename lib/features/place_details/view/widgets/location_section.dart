import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/features/explore/data/models/place_model.dart';

class LocationSection extends StatelessWidget {
  final PlaceModel place;

  const LocationSection({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final hasCoordinates = place.latitude != null && place.longitude != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        SizedBox(height: 10.h),

        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            children: [
              Container(
                width: 45.w,
                height: 45.w,
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(13.r),
                ),
                child: const Icon(
                  Icons.location_on_outlined,
                  color: Colors.red,
                ),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${place.city}, ${place.country}',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),

                    if (hasCoordinates) ...[
                      SizedBox(height: 4.h),
                      Text(
                        '${place.latitude!.toStringAsFixed(4)}, '
                        '${place.longitude!.toStringAsFixed(4)}',
                        style: TextStyle(fontSize: 9.sp, color: Colors.grey),
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
