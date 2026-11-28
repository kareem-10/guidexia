import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tourist_app/core/di/dependancy_injection.dart';
import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/core/widgets/favorite_icon_button.dart';
import 'package:tourist_app/features/explore/data/models/place_model.dart';
import 'package:tourist_app/features/place_details/view/place_details_screen.dart';
import 'package:tourist_app/features/place_details/view_model/cubit/place_details_cubit.dart';

class PlaceCard extends StatelessWidget {
  final PlaceModel place;

  const PlaceCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final imageUrl = place.thumbnailUrl.isNotEmpty
        ? place.thumbnailUrl
        : place.imageUrl;

    return Material(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(22.r),
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      shadowColor: Colors.black.withValues(alpha: 0.12),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) =>
                    getIt<PlaceDetailsCubit>()..getActivities(place.id),
                child: PlaceDetailsScreen(place: place),
              ),
            ),
          );
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            Hero(
              tag: place.id,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 400),
                placeholder: (_, _) =>
                    Image.asset('assets/images/loading.gif', fit: BoxFit.cover),
                errorWidget: (_, _, _) => Container(
                  color: scheme.surfaceContainerHighest,
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: scheme.onSurfaceVariant,
                    size: 30.sp,
                  ),
                ),
              ),
            ),

            // Dark gradient
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.35, 1.0],
                  colors: [
                    Colors.black.withValues(alpha: 0.28),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.78),
                  ],
                ),
              ),
            ),

            // Category
            Positioned(
              top: 11.h,
              left: 10.w,
              child: _GlassBadge(
                child: Text(
                  _displayCategory(place.category),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // Favorite
            Positioned(
              top: 7.h,
              right: 7.w,
              child: FavoriteIconButton(
                entityId: place.id,
                entityType: 'Place',
              ),
            ),

            // Rating
            Positioned(
              top: 52.h,
              left: 10.w,
              child: _GlassBadge(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: const Color(0xFFFFC857),
                      size: 13.sp,
                    ),
                    horizontalSpace(3),
                    Text(
                      place.averageRating.toStringAsFixed(1),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Place information
            Positioned(
              bottom: 13.h,
              left: 11.w,
              right: 10.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    place.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ),
                  verticalSpace(7),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: Colors.white.withValues(alpha: 0.85),
                        size: 13.sp,
                      ),
                      horizontalSpace(3),
                      Expanded(
                        child: Text(
                          '${place.city}, ${place.country}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w500,
                          ),
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

class _GlassBadge extends StatelessWidget {
  final Widget child;

  const _GlassBadge({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.38),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: child,
    );
  }
}
