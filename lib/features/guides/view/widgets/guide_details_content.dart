import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tourist_app/core/widgets/favorite_icon_button.dart';
import 'package:tourist_app/core/widgets/round_button.dart';
import 'package:tourist_app/features/guides/data/models/guide_model.dart';
import 'package:tourist_app/features/guides/view/widgets/guide_details_about.dart';
import 'package:tourist_app/features/guides/view/widgets/guide_details_header.dart';

class GuideDetailsContent extends StatelessWidget {
  final GuideModel guide;

  const GuideDetailsContent({super.key, required this.guide});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 330.h,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: EdgeInsets.all(8.w),
              child: RoundButton(
                icon: Icons.arrow_back,
                onTap: () => Navigator.pop(context),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.all(10.w),
                child: FavoriteIconButton(
                  entityId: guide.id,
                  entityType: 'Guide',
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.r),
                  bottomRight: Radius.circular(25.r),
                ),
                child: GuideDetailsHeader(guide: guide),
              ),
            ),
          ),
          SliverToBoxAdapter(child: GuideDetailsAbout(guide: guide)),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 12.h),
          decoration: BoxDecoration(
            color: scheme.surface,
            border: Border(top: BorderSide(color: scheme.outlineVariant)),
          ),
          child: FilledButton(
            onPressed: null,
            style: FilledButton.styleFrom(
              backgroundColor: scheme.primary,
              disabledBackgroundColor: scheme.surfaceContainerHighest,
              padding: EdgeInsets.symmetric(vertical: 15.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.r),
              ),
            ),
            child: Text(
              'Booking unavailable',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ),
        ),
      ),
    );
  }
}
