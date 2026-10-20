import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/utils/app_colors.dart';
import 'package:tourist_app/core/widgets/favorite_icon_button.dart';
import 'package:tourist_app/core/widgets/round_button.dart';
import 'package:tourist_app/features/guides/view/widgets/state_widget.dart';
import 'package:tourist_app/features/saved/view_model/cubit/saved_cubit.dart';
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
                          color: const Color(0xFFE9EFF0),
                          child: Icon(
                            Icons.landscape,
                            size: 64,
                            color: AppColors.primaryColor,
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
                                  const Icon(
                                    Icons.verified,
                                    color: Colors.lightBlueAccent,
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
                                const Icon(
                                  Icons.star_rounded,
                                  color: Color(0xFFFFC15A),
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
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFE5E9EC)),
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
                  _sectionTitle('About ${guide.name}'),
                  SizedBox(height: 8.h),
                  Text(
                    guide.bio.isEmpty
                        ? 'A guide profile description will be available when the backend provides it.'
                        : guide.bio,
                    style: TextStyle(
                      color: const Color(0xFF59636B),
                      height: 1.55,
                      fontSize: 14.sp,
                    ),
                  ),
                  if (_split(guide.specialties).isNotEmpty) ...[
                    SizedBox(height: 23.h),
                    _sectionTitle('Specialties'),
                    SizedBox(height: 10.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: _split(
                        guide.specialties,
                      ).map((s) => _chip(s)).toList(),
                    ),
                  ],
                  if (_split(guide.languages).isNotEmpty) ...[
                    SizedBox(height: 23.h),
                    _sectionTitle('Languages'),
                    SizedBox(height: 10.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: _split(
                        guide.languages,
                      ).map((s) => _chip(s)).toList(),
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
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xFFE5E9EC))),
          ),
          child: FilledButton(
            onPressed: null,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              disabledBackgroundColor: const Color(0xFFB8CBCD),
              padding: EdgeInsets.symmetric(vertical: 15.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.r),
              ),
            ),
            child: const Text('Booking unavailable'),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String value) => Text(
    value,
    style: TextStyle(
      fontSize: 17.sp,
      color: const Color(0xFF252D33),
      fontWeight: FontWeight.w800,
    ),
  );

  Widget _chip(String value) => Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE0E6E8)),
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: Text(
      value,
      style: TextStyle(fontSize: 12.sp, color: const Color(0xFF59636B)),
    ),
  );
}
