import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/core/widgets/search_bar_widget.dart';
import 'package:tourist_app/features/guides/data/models/guide_model.dart';
import 'package:tourist_app/features/guides/view/widgets/guide_card.dart';
import 'package:tourist_app/features/guides/view/widgets/guides_shimmer.dart';
import 'package:tourist_app/features/guides/view_model/guide_cubit/guides_cubit.dart';
import 'package:tourist_app/features/guides/view_model/guide_cubit/guides_state.dart';

class GuideState extends StatefulWidget {
  const GuideState({super.key});

  @override
  State<GuideState> createState() => _GuideStateState();
}

class _GuideStateState extends State<GuideState> {
  @override
  Widget build(BuildContext context) {
    String query = '';
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 4, 18, 12),
          child: SearchBarWidget(
            hintText: 'Search guides, languages, specialties...',
            onChanged: (value) {
              setState(() => query = value.trim().toLowerCase());
            },
          ),
        ),

        Expanded(
          child: BlocBuilder<GuidesCubit, GuidesState>(
            builder: (context, state) {
              if (state is GuidesLoading || state is GuidesInitial) {
                return const GuidesShimmer();
              }
              if (state is GuidesFailure) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(state.message, textAlign: TextAlign.center),
                        verticalSpace(12),
                        ElevatedButton(
                          onPressed: context.read<GuidesCubit>().loadGuides,
                          child: const Text('Try again'),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (state is GuidesSuccess) {
                final List<GuideModel> guides = state.guides
                    .where(
                      (g) =>
                          '${g.fullName} ${g.location} ${g.languages} ${g.specialties}'
                              .toLowerCase()
                              .contains(query),
                    )
                    .toList();
                if (guides.isEmpty) {
                  return Center(
                    child: Text(
                      'No guides found.',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Text(
                        '${guides.length} guides available',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 75),
                        child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(18, 0, 18, 20),
                          itemCount: guides.length,
                          separatorBuilder: (_, _) => verticalSpace(12),
                          itemBuilder: (context, index) =>
                              GuideCard(guide: guides[index]),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
