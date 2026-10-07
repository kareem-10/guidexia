import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/features/explore/data/models/place_model.dart';
import 'package:tourist_app/features/place_details/view/place_details_screen.dart';

class PlaceCard extends StatelessWidget {
  final PlaceModel place;

  const PlaceCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PlaceDetailsScreen(place: place)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff1B1E1E),
          borderRadius: BorderRadius.circular(17.r),
          border: Border.all(color: Colors.grey.shade800),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl: place.thumbnailUrl.isNotEmpty
                          ? place.thumbnailUrl
                          : place.imageUrl,
                      fit: BoxFit.cover,
                      fadeInDuration: const Duration(milliseconds: 500),
                      fadeOutDuration: const Duration(milliseconds: 500),
                      fadeInCurve: Curves.easeIn,
                      fadeOutCurve: Curves.easeOut,
                      placeholder: (_, _) {
                        return Image.asset(
                          'assets/images/loading.gif',
                          fit: BoxFit.cover,
                        );
                      },
                      errorWidget: (_, _, _) {
                        return const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),

                  Positioned(
                    top: 10.h,
                    left: 10.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 9.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.65),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        _displayCategory(place.category),
                        style: TextStyle(color: Colors.white, fontSize: 8.sp),
                      ),
                    ),
                  ),

                  if (place.isFeatured)
                    Positioned(
                      bottom: 10.h,
                      left: 10.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          'Featured',
                          style: TextStyle(color: Colors.white, fontSize: 8.sp),
                        ),
                      ),
                    ),

                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: Container(
                      width: 30.w,
                      height: 30.w,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        place.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Icon(Icons.star, size: 15.sp, color: Colors.orange),

                    SizedBox(width: 3.w),

                    Text(
                      place.averageRating.toStringAsFixed(1),
                      style: TextStyle(color: Colors.orange, fontSize: 10.sp),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey,
                      size: 13.sp,
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Text(
                        '${place.city}, ${place.country}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey, fontSize: 9.sp),
                      ),
                    ),
                  ],
                ),
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
        return 'Coastal escape';
      case 'Cultural':
        return 'Culture';
      case 'Historic':
        return 'History';
      default:
        return category;
    }
  }
}
