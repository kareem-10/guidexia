import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tourist_app/features/guides/view/widgets/guide_details_state_view.dart';
import 'package:tourist_app/features/guides/view_model/guide_details_cubit/guide_details_cubit.dart';

class GuideDetailsScreen extends StatelessWidget {
  final int guideId;

  const GuideDetailsScreen({super.key, required this.guideId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<GuideDetailsCubit>()..loadGuideDetails(guideId),
      child: GuideDetailsStateView(guideId: guideId),
    );
  }
}
