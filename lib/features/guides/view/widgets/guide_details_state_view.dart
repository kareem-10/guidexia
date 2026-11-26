import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/features/guides/view/widgets/guide_details_content.dart';
import 'package:tourist_app/features/guides/view_model/guide_details_cubit/guide_details_cubit.dart';
import 'package:tourist_app/features/guides/view_model/guide_details_cubit/guide_details_state.dart';

class GuideDetailsStateView extends StatelessWidget {
  final int guideId;

  const GuideDetailsStateView({super.key, required this.guideId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuideDetailsCubit, GuideDetailsState>(
      builder: (context, state) {
        if (state is GuideDetailsLoading || state is GuideDetailsInitial) {
          return const Scaffold(
            body: Center(
              child: Image(image: AssetImage('assets/images/loading.gif')),
            ),
          );
        }

        if (state is GuideDetailsFailure) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 48),
                    const SizedBox(height: 12),
                    Text(state.message, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<GuideDetailsCubit>().loadGuideDetails(
                          guideId,
                        );
                      },
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (state is GuideDetailsSuccess) {
          return GuideDetailsContent(guide: state.guide);
        }

        return const SizedBox.shrink();
      },
    );
  }
}
