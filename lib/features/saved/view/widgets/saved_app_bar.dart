import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/utils/app_colors.dart';
import 'package:tourist_app/core/widgets/app_bar_title.dart';

class SavedAppBar extends StatelessWidget {
  const SavedAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const AppBarTitle(text: 'Saved'),
      automaticallyImplyLeading: false,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(58.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Container(
            height: 46.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: TabBar(
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.all(4.w),
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              indicator: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16.r),
              ),
              labelColor: AppColors.primaryColor,
              unselectedLabelColor: Colors.black,
              labelStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
              tabs: const [
                Tab(text: 'Places'),
                Tab(text: 'Guides'),
                Tab(text: 'Stays'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
