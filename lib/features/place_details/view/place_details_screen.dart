import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/core/widgets/favorite_icon_button.dart';
import 'package:tourist_app/core/widgets/round_button.dart';
import 'package:tourist_app/features/explore/data/models/place_model.dart';
import 'package:tourist_app/features/place_details/view/widgets/about_section.dart';
import 'package:tourist_app/features/place_details/view/widgets/activities_section.dart';
import 'package:tourist_app/features/place_details/view/widgets/entry_fee_section.dart';
import 'package:tourist_app/features/place_details/view/widgets/location_section.dart';
import 'package:tourist_app/features/place_details/view/widgets/place_details_app_bar.dart';
import 'package:tourist_app/features/place_details/view/widgets/rating_section.dart';
import 'package:tourist_app/features/place_details/view/widgets/tags_section.dart';
import 'package:tourist_app/features/reviews/view/reviews_section.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final PlaceModel place;

  const PlaceDetailsScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          PlaceDetailsAppBar(place: place),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 50.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingSection(place: place),

                  verticalSpace(28),

                  AboutSection(description: place.description),

                  verticalSpace(28),

                  ActivitiesSection(placeId: place.id),

                  verticalSpace(28),

                  EntryFeeSection(entryFee: place.entryFee),

                  if (place.tags.isNotEmpty) ...[
                    verticalSpace(28),
                    TagsSection(tags: place.tags),
                  ],

                  verticalSpace(28),

                  LocationSection(place: place),

                  verticalSpace(30),

                  ReviewsSection(referenceType: 'Place', referenceId: place.id),

                  verticalSpace(30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
