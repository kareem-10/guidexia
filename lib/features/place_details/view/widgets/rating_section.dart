import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/features/explore/data/models/place_model.dart';

class RatingSection extends StatelessWidget {
  final PlaceModel place;

  const RatingSection({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: scheme.tertiary.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(Icons.star_rounded, color: scheme.tertiary, size: 28),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                place.averageRating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                  color: scheme.onSurface,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                '${place.reviewCount} reviews',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            _ratingText(place.averageRating),
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  String _ratingText(double rating) {
    if (rating >= 4.5) return 'Excellent';
    if (rating >= 4) return 'Very good';
    if (rating >= 3) return 'Good';
    return 'Average';
  }
}
