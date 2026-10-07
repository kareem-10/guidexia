import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/utils/app_colors.dart';
import 'package:tourist_app/features/explore/data/models/place_model.dart';
import 'package:tourist_app/features/place_details/view/widgets/about_section.dart';
import 'package:tourist_app/features/place_details/view/widgets/circle_button.dart';
import 'package:tourist_app/features/place_details/view/widgets/entry_fee_section.dart';
import 'package:tourist_app/features/place_details/view/widgets/location_section.dart';
import 'package:tourist_app/features/place_details/view/widgets/rating_section.dart';
import 'package:tourist_app/features/place_details/view/widgets/tags_section.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final PlaceModel place;

  const PlaceDetailsScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F5),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.h,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,

            leading: Padding(
              padding: EdgeInsets.all(8.w),
              child: CircleButton(
                icon: Icons.arrow_back,
                onTap: () => Navigator.pop(context),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.all(8.w),
                child: CircleButton(
                  icon: Icons.favorite_border,
                  onTap: () {
                    // Favorites will be connected here later.
                  },
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.r),
                  bottomRight: Radius.circular(25.r),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: place.imageUrl.isNotEmpty
                          ? place.imageUrl
                          : place.thumbnailUrl,
                      fit: BoxFit.cover,
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
                            size: 40,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),

                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.15),
                              Colors.black.withValues(alpha: 0.65),
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
                          if (place.isFeatured)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 5.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                'Featured',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                          SizedBox(height: 8.h),

                          Text(
                            place.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 27.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 5.h),

                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.white70,
                                size: 16,
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Text(
                                  '${place.city}, ${place.country}',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12.sp,
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
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 30.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingSection(place: place),

                  SizedBox(height: 22.h),

                  AboutSection(description: place.description),

                  SizedBox(height: 22.h),

                  EntryFeeSection(entryFee: place.entryFee),

                  if (place.tags.isNotEmpty) ...[
                    SizedBox(height: 22.h),
                    TagsSection(tags: place.tags),
                  ],

                  SizedBox(height: 22.h),

                  LocationSection(place: place),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
