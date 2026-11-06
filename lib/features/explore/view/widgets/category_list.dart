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
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 38.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          final category = categories[index];

          return BlocBuilder<ExploreCubit, ExploreState>(
            builder: (context, state) {
              final selected =
                  context.read<ExploreCubit>().selectedCategory ==
                  category['api'];

              return GestureDetector(
                onTap: () {
                  context.read<ExploreCubit>().selectCategory(category['api']!);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected
                        ? scheme.primary
                        : scheme.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: selected
                          ? scheme.outlineVariant
                          : Colors.transparent,
                    ),
                  ),
                  child: Text(
                    category['name']!,
                    style: TextStyle(
                      color: selected ? scheme.onPrimary : scheme.onSurface,
                      fontSize: 11.sp,
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
