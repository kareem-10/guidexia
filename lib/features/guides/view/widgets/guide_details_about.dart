import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/features/guides/data/models/guide_model.dart';
import 'package:tourist_app/features/guides/view/widgets/state_widget.dart';

class GuideDetailsAbout extends StatelessWidget {
  final GuideModel guide;
  const GuideDetailsAbout({super.key, required this.guide});

  List<String> _split(String value) => value
      .split(RegExp(r'[,;|]'))
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.all(18.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 8.w),
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
                StatWidget(value: '${guide.reviewCount}', label: 'Reviews'),
                StatWidget(
                  value: '${guide.happyTravelers}',
                  label: 'Travelers',
                ),
              ],
            ),
          ),
          SizedBox(height: 23.h),
          _sectionTitle(context, 'About ${guide.fullName}'),
          SizedBox(height: 8.h),
          Text(
            guide.bio.isEmpty ? '' : guide.bio,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
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
