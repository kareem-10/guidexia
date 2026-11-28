import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ExploreShimmer extends StatelessWidget {
  const ExploreShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final base = scheme.brightness == Brightness.dark
        ? const Color(0xFF292929)
        : const Color(0xFFE5E8EB);

    final highlight = scheme.brightness == Brightness.dark
        ? const Color(0xFF3A3A3A)
        : const Color(0xFFF7F8FA);

    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 3.h, bottom: 100.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 13.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: 0.70,
        ),
        itemCount: 6,
        itemBuilder: (_, _) {
          return Container(
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(22.r),
            ),
          );
        },
      ),
    );
  }
}
