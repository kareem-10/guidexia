import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/features/explore/view/widgets/category_list.dart';
import 'package:tourist_app/features/explore/view/widgets/explore_header.dart';
import 'package:tourist_app/features/explore/view/widgets/explore_search_bar.dart';
import 'package:tourist_app/features/explore/view/widgets/explore_shimmer.dart';
import 'package:tourist_app/features/explore/view/widgets/places_grid.dart';
import 'package:tourist_app/features/explore/view_model/cubit/explore_cubit.dart';
import 'package:tourist_app/features/explore/view_model/cubit/explore_state.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<ExploreCubit>().getPlaces();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ExploreHeader(),

              verticalSpace(16),
              ExploreSearchBar(
                controller: searchController,
                onChanged: (value) {
                  context.read<ExploreCubit>().searchPlaces(value);
                },
              ),

              verticalSpace(16),

              const CategoryList(),

              verticalSpace(20),
              Expanded(
                child: BlocBuilder<ExploreCubit, ExploreState>(
                  builder: (context, state) {
                    if (state is ExploreLoading) {
                      return const ExploreShimmer();
                    }

                    if (state is ExploreFailure) {
                      return Center(child: Text(state.message));
                    }

                    if (state is ExploreSuccess) {
                      if (state.places.isEmpty) {
                        return const Center(child: Text('No places found'));
                      }

                      return PlacesGrid(places: state.places);
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
