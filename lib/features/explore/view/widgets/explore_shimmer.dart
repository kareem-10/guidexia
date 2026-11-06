import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ExploreShimmer extends StatelessWidget {
  const ExploreShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(bottom: 20.h),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 14.h,
        childAspectRatio: 0.72,
      ),
      itemCount: 6,
      itemBuilder: (_, _) {
        return const ShimmerPlaceCard();
      },
    );
  }
}

class ShimmerPlaceCard extends StatelessWidget {
  const ShimmerPlaceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final base = scheme.brightness == Brightness.dark
        ? const Color(0xFF2C2C2C)
        : const Color(0xFFE7EAEC);
    final highlight = scheme.brightness == Brightness.dark
        ? const Color(0xFF3A3A3A)
        : const Color(0xFFF7F8F9);
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Container(
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(17.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 6, child: Container(color: scheme.surface)),

            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: scheme.surface,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                    ),

                    SizedBox(width: 10.w),

                    Container(
                      width: 28.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: scheme.surface,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Container(
                  height: 8.h,
                  width: 55.w,
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
