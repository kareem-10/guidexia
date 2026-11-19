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
      padding: EdgeInsets.only(bottom: 20.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 14.h,
        childAspectRatio: 0.72,
      ),
      builderDelegate: PagedChildBuilderDelegate<PlaceModel>(
        itemBuilder: (context, place, index) {
          return PlaceCard(place: place);
        },
        noItemsFoundIndicatorBuilder: (context) {
          return const Center(child: Text('No places found'));
        },
      ),
    );
  }
}
