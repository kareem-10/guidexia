import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/widgets/favorite_icon_button.dart';
import 'package:tourist_app/core/widgets/round_button.dart';
import 'package:tourist_app/features/guides/view/widgets/state_widget.dart';
import '../../data/models/guide_model.dart';

class GuideDetailsScreen extends StatelessWidget {
  final GuideModel guide;
  const GuideDetailsScreen({super.key, required this.guide});

  List<String> _split(String value) => value
      .split(RegExp(r'[,;]'))
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();

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
                child: Hero(
                  tag: guide.id,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: guide.coverImageUrl ?? '',
                        fit: BoxFit.cover,
                        errorWidget: (_, _, _) => Container(
                          color: scheme.surfaceContainerHighest,
                          child: Icon(
                            Icons.landscape,
                            size: 64,
                            color: scheme.primary,
                          ),
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
                                    guide.name,
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
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13.sp,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  color: scheme.tertiary,
                                  size: 19,
                                ),
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
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 17.h,
                      horizontal: 8.w,
                    ),
                    decoration: BoxDecoration(
                      color: scheme.surface,
                      border: Border.all(color: scheme.outlineVariant),
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child: Row(
                      children: [
                        StatWidget(
                          value: '${guide.experienceYears} yrs',
                          label: 'Experience',
                        ),
                        StatWidget(
                          value: '${guide.reviewCount}',
                          label: 'Reviews',
                        ),
                        StatWidget(
                          value: '${guide.happyTravelers}',
                          label: 'Travelers',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 23.h),
                  _sectionTitle(context, 'About ${guide.name}'),
                  SizedBox(height: 8.h),
                  Text(
                    guide.bio.isEmpty
                        ? 'A guide profile description will be available when the backend provides it.'
                        : guide.bio,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      height: 1.55,
                      fontSize: 14.sp,
                    ),
                  ),
                  if (_split(guide.specialties).isNotEmpty) ...[
                    SizedBox(height: 23.h),
                    _sectionTitle(context, 'Specialties'),
                    SizedBox(height: 10.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: _split(
                        guide.specialties,
                      ).map((s) => _chip(context, s)).toList(),
                    ),
                  ],
                  if (_split(guide.languages).isNotEmpty) ...[
                    SizedBox(height: 23.h),
                    _sectionTitle(context, 'Languages'),
                    SizedBox(height: 10.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: _split(
                        guide.languages,
                      ).map((s) => _chip(context, s)).toList(),
                    ),
                  ],
                  SizedBox(height: 90.h),
                ],
              ),
            ),
          ),
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

  Widget _sectionTitle(BuildContext context, String value) => Text(
    value,
    style: TextStyle(
      fontSize: 17.sp,
      color: Theme.of(context).colorScheme.onSurface,
      fontWeight: FontWeight.w800,
    ),
  );

  Widget _chip(BuildContext context, String value) => Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: Text(
      value,
      style: TextStyle(
        fontSize: 12.sp,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    ),
  );
}
