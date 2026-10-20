import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/features/guides/view/widgets/guide_card.dart';
import 'package:tourist_app/features/saved/view/widgets/saved_empty_state.dart';
import 'package:tourist_app/features/saved/view_model/cubit/saved_cubit.dart';
import 'package:tourist_app/features/saved/view_model/cubit/saved_state.dart';

class SavedGuidesTab extends StatelessWidget {
  const SavedGuidesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedCubit, SavedState>(
      builder: (context, state) {
        if (state is SavedInitial || state is SavedLoading) {
          return const Center(
            child: Image(image: AssetImage('assets/images/loading.gif')),
          );
        }

        if (state is SavedFailure) {
          return Center(child: Text(state.message));
        }

        if (state is! SavedSuccess) {
          return const SizedBox.shrink();
        }

        if (state.guides.isEmpty) {
          return const SavedEmptyState(
            title: 'No saved guides yet',
            subtitle: 'Save your favorite guides to find them here.',
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: state.guides.length,
          separatorBuilder: (_, _) => verticalSpace(12),
          itemBuilder: (context, index) {
            final guide = state.guides[index];
            return GuideCard(guide: guide);
          },
        );
      },
    );
  }
}
