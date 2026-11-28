import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:tourist_app/features/explore/data/models/place_model.dart';
import 'package:tourist_app/features/explore/view/widgets/place_card.dart';

class PlacesGrid extends StatelessWidget {
  final PagingState<int, PlaceModel> pagingState;
  final VoidCallback fetchNextPage;

  const PlacesGrid({
    super.key,
    required this.pagingState,
    required this.fetchNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return PagedGridView<int, PlaceModel>(
      state: pagingState,
      fetchNextPage: fetchNextPage,
      padding: EdgeInsets.only(top: 3.h, bottom: 100.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 13.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.70,
      ),
      builderDelegate: PagedChildBuilderDelegate<PlaceModel>(
        itemBuilder: (context, place, index) {
          return PlaceCard(place: place);
        },
        noItemsFoundIndicatorBuilder: (context) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.travel_explore_rounded,
                  size: 42.sp,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                SizedBox(height: 12.h),
                Text(
                  'No places found',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 5.h),
                Text(
                  'Try searching for another destination.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
