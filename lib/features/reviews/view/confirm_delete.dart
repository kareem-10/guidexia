import 'package:flutter/material.dart';

import 'package:tourist_app/core/functions/show_toast.dart';
import 'package:tourist_app/features/reviews/view_model/cubit/reviews_cubit.dart';

Future<void> confirmDeleteReview(
  BuildContext context,
  ReviewsCubit cubit, {
  required String referenceType,
  required int referenceId,
  required int reviewId,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Delete Review'),
      content: const Text('Are you sure you want to delete this review?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: const Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );

  if (confirmed != true || !context.mounted) return;

  final success = await cubit.deleteReview(
    reviewId: reviewId,
    referenceType: referenceType,
    referenceId: referenceId,
  );

  if (!context.mounted) return;

  showToast(
    success
        ? 'Review deleted successfully'
        : cubit.state.errorMessage ?? 'Failed to delete review',
  );
}
