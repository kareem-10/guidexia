import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/core/widgets/app_bar_title.dart';
import 'package:tourist_app/core/widgets/search_bar_widget.dart';
import 'package:tourist_app/features/guides/view/screens/guide_details_screen.dart';
import '../../data/models/guide_model.dart';
import '../../view_model/cubit/guides_cubit.dart';
import '../../view_model/cubit/guides_state.dart';
import '../widgets/guide_card.dart';
import '../widgets/guides_shimmer.dart';

class GuidesScreen extends StatelessWidget {
  const GuidesScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<GuidesCubit>()..loadGuides(),
    child: const _GuidesView(),
  );
}

class _GuidesView extends StatefulWidget {
  const _GuidesView();
  @override
  State<_GuidesView> createState() => _GuidesViewState();
}

class _GuidesViewState extends State<_GuidesView> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          title: AppBarTitle(text: 'Find Guide'),
        ),
        body: Column(
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
                              '${g.name} ${g.location} ${g.languages} ${g.specialties}'
                                  .toLowerCase()
                                  .contains(query),
                        )
                        .toList();
                    if (guides.isEmpty) {
                      return const Center(
                        child: Text(
                          'No guides found.',
                          style: TextStyle(color: Colors.blueGrey),
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
                              color: Colors.blueGrey,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.fromLTRB(18, 0, 18, 20),
                            itemCount: guides.length,
                            separatorBuilder: (_, _) => verticalSpace(12),
                            itemBuilder: (context, index) => GuideCard(
                              guide: guides[index],
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: context.read<GuidesCubit>(),
                                    child: GuideDetailsScreen(
                                      guide: guides[index],
                                    ),
                                  ),
                                ),
                              ),
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
        ),
      ),
    );
  }
}
