import 'package:flutter/material.dart';
import 'package:tourist_app/core/functions/show_toast.dart';
import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/features/reviews/view/widgets/review_comment_field.dart';
import 'package:tourist_app/features/reviews/view/widgets/review_rating_selector.dart';
import 'package:tourist_app/features/reviews/view_model/cubit/reviews_cubit.dart';

class AddReviewDialog extends StatefulWidget {
  final ReviewsCubit cubit;
  final String referenceType;
  final int referenceId;

  const AddReviewDialog({
    super.key,
    required this.cubit,
    required this.referenceType,
    required this.referenceId,
  });

  @override
  State<AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  late final TextEditingController _commentController;

  int _rating = 5;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    final comment = _commentController.text.trim();

    if (comment.isEmpty || _isSubmitting) return;

    setState(() => _isSubmitting = true);

    final success = await widget.cubit.addReview(
      referenceType: widget.referenceType,
      referenceId: widget.referenceId,
      rating: _rating,
      comment: comment,
    );

    if (!mounted) return;

    if (success) {
      Navigator.pop(context);
      showToast('Review added successfully');
    } else {
      setState(() => _isSubmitting = false);
      showToast(widget.cubit.state.errorMessage ?? 'Could not add review');
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: AlertDialog(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
        contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
        actionsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        title: _buildTitle(context, scheme),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReviewRatingSelector(
              rating: _rating,
              enabled: !_isSubmitting,
              onChanged: (value) => setState(() => _rating = value),
            ),
            verticalSpace(20),
            Text(
              'Your comment',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            verticalSpace(8),
            ReviewCommentField(
              controller: _commentController,
              enabled: !_isSubmitting,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: _isSubmitting ? null : () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: _isSubmitting ? null : _submitReview,
            child: _isSubmitting
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Submit Review'),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, ColorScheme scheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Write a Review',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            IconButton(
              onPressed: _isSubmitting ? null : () => Navigator.pop(context),
              icon: const Icon(Icons.close_rounded),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
        Text(
          'Share your experience with other travelers',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: scheme.onSurfaceVariant,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
