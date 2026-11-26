import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/features/guides/data/models/guide_model.dart';

class GuideDetailsHeader extends StatelessWidget {
  final GuideModel guide;
  const GuideDetailsHeader({super.key, required this.guide});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Hero(
      tag: guide.id,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: guide.coverImageUrl ?? '',
            fit: BoxFit.cover,
            errorWidget: (_, _, _) => Container(
              color: scheme.surfaceContainerHighest,
              child: Icon(Icons.landscape, size: 64, color: scheme.primary),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    scheme.shadow.withValues(alpha: 0.15),
                    scheme.shadow.withValues(alpha: 0.65),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 20.w,
            right: 20.w,
            bottom: 20.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        guide.fullName,
                        style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (guide.isVerified) ...[
                      SizedBox(width: 6.w),
                      Icon(
                        Icons.verified,
                        color: scheme.inversePrimary,
                        size: 20,
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 5.h),
                Text(
                  guide.location,
                  style: TextStyle(color: Colors.white70, fontSize: 13.sp),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.star_rounded, color: scheme.tertiary, size: 19),
                    SizedBox(width: 4.w),
                    Text(
                      '${guide.averageRating.toStringAsFixed(1)} (${guide.reviewCount})',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
