import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/features/explore/view_model/cubit/explore_cubit.dart';
import 'package:tourist_app/features/explore/view_model/cubit/explore_state.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  static const categories = [
    {'name': 'All', 'api': 'All'},
    {'name': 'Beaches', 'api': 'Beaches'},
    {'name': 'Culture', 'api': 'Cultural'},
    {'name': 'Coastal escape', 'api': 'CoastalEscape'},
    {'name': 'Island', 'api': 'Island'},
    {'name': 'History', 'api': 'Historic'},
    {'name': 'Nature', 'api': 'Nature'},
    {'name': 'Leisure', 'api': 'Leisure'},
    {'name': 'Religious', 'api': 'Religious'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 39.h,
      child: BlocBuilder<ExploreCubit, ExploreState>(
        builder: (context, state) {
          final cubit = context.read<ExploreCubit>();
          final scheme = Theme.of(context).colorScheme;

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, _) => SizedBox(width: 9.w),
            itemBuilder: (context, index) {
              final category = categories[index];

              final selected = cubit.selectedCategory == category['api'];

              return GestureDetector(
                onTap: () {
                  cubit.selectCategory(category['api']!);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.symmetric(horizontal: 17.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected
                        ? scheme.primary
                        : scheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(
                      color: selected
                          ? scheme.primary
                          : scheme.outlineVariant.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Text(
                    category['name']!,
                    style: TextStyle(
                      color: selected
                          ? scheme.onPrimary
                          : scheme.onSurfaceVariant,
                      fontSize: 11.sp,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
