import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/helpers/spacing.dart';

class EntryFeeSection extends StatelessWidget {
  final double entryFee;

  const EntryFeeSection({super.key, required this.entryFee});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isFree = entryFee <= 0;

    return Container(
      padding: EdgeInsets.all(17.w),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: scheme.primary.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.13),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              Icons.confirmation_number_outlined,
              color: scheme.primary,
              size: 25.sp,
            ),
          ),

          horizontalSpace(13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Entry fee',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                verticalSpace(4),
                Text(
                  isFree ? 'Free Entry' : '${entryFee.toStringAsFixed(0)} EGP',
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w800,
                    color: scheme.onSurface,
                  ),
                ),
              ],
            ),
          ),

          if (isFree)
            Icon(
              Icons.check_circle_rounded,
              color: scheme.primary,
              size: 22.sp,
            ),
        ],
      ),
    );
  }
}
