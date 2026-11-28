import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/features/explore/data/models/place_model.dart';

class PlaceHero extends StatelessWidget {
  final PlaceModel place;

  const PlaceHero({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final imageUrl = place.imageUrl.isNotEmpty
        ? place.imageUrl
        : place.thumbnailUrl;

    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30.r),
        bottomRight: Radius.circular(30.r),
      ),
      child: Hero(
        tag: place.id,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 500),
              placeholder: (_, _) =>
                  Image.asset('assets/images/loading.gif', fit: BoxFit.cover),
              errorWidget: (_, _, _) => Container(
                color: scheme.surfaceContainerHighest,
                child: Icon(
                  Icons.image_not_supported_outlined,
                  size: 40.sp,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),

            // Cinematic gradient
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.35, 0.65, 1.0],
                  colors: [
                    Colors.black.withValues(alpha: 0.35),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.25),
                    Colors.black.withValues(alpha: 0.85),
                  ],
                ),
              ),
            ),

            // Place information
            Positioned(
              left: 22.w,
              right: 22.w,
              bottom: 30.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeroBadge(
                    icon: Icons.explore_outlined,
                    label: _displayCategory(place.category),
                  ),

                  verticalSpace(13),

                  Text(
                    place.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 29.sp,
                      fontWeight: FontWeight.w800,
                      height: 1.15,
                      letterSpacing: -0.5,
                    ),
                  ),

                  verticalSpace(9),

                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: Colors.white.withValues(alpha: 0.9),
                        size: 17.sp,
                      ),
                      horizontalSpace(5),
                      Expanded(
                        child: Text(
                          '${place.city}, ${place.country}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  verticalSpace(13),

                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: const Color(0xFFFFC857),
                        size: 19.sp,
                      ),
                      horizontalSpace(5),
                      Text(
                        place.averageRating.toStringAsFixed(1),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      horizontalSpace(5),
                      Text(
                        '(${place.reviewCount} reviews)',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _displayCategory(String category) {
    switch (category) {
      case 'CoastalEscape':
        return 'Coastal Escape';
      case 'Cultural':
        return 'Culture';
      case 'Historic':
        return 'History';
      default:
        return category;
    }
  }
}

class _HeroBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const _HeroBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.19),
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 13.sp),
          horizontalSpace(6),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
