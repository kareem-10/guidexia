import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/widgets/favorite_icon_button.dart';
import 'package:tourist_app/core/widgets/round_button.dart';
import 'package:tourist_app/features/explore/data/models/place_model.dart';
import 'package:tourist_app/features/place_details/view/widgets/place_hero.dart';

class PlaceDetailsAppBar extends StatelessWidget {
  final PlaceModel place;
  const PlaceDetailsAppBar({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SliverAppBar(
      expandedHeight: 380.h,
      pinned: true,
      stretch: true,
      backgroundColor: scheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: EdgeInsets.all(8.w),
        child: RoundButton(
          icon: Icons.arrow_back_rounded,
          onTap: () => Navigator.pop(context),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.all(8.w),
          child: FavoriteIconButton(entityId: place.id, entityType: 'Place'),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: PlaceHero(place: place),
      ),
    );
  }
}
