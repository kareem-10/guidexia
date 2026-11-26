import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tourist_app/core/widgets/app_bar_title.dart';
import 'package:tourist_app/features/guides/view/widgets/guide_body_state.dart';
import '../../view_model/guide_cubit/guides_cubit.dart';

class GuidesScreen extends StatelessWidget {
  const GuidesScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<GuidesCubit>()..loadGuides(),
    child: const _GuidesView(),
  );
}

class _GuidesView extends StatelessWidget {
  const _GuidesView();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          title: AppBarTitle(text: 'Find Guide'),
        ),
        body: GuideState(),
      ),
    );
  }
}
