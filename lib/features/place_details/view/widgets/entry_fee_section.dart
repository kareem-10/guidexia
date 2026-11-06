import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EntryFeeSection extends StatelessWidget {
  final double entryFee;

  const EntryFeeSection({super.key, required this.entryFee});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isFree = entryFee <= 0;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 45.w,
            height: 45.w,
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(13.r),
            ),
            child: Icon(
              Icons.payments_outlined,
              color: scheme.primary,
              size: 23.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Entry Fee',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                isFree ? 'Free Entry' : '${entryFee.toStringAsFixed(0)} EGP',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: scheme.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
