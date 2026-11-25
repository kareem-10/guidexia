import 'package:flutter/material.dart';
import 'package:tourist_app/core/functions/show_toast.dart';
import 'package:tourist_app/features/reviews/view_model/cubit/reviews_cubit.dart';

void showAddReviewDialog(
  BuildContext context,
  ReviewsCubit cubit, {
  required int placeId,
}) {
  showDialog(
    context: context,
    builder: (_) => AddReviewDialog(cubit: cubit, placeId: placeId),
  );
}

class AddReviewDialog extends StatefulWidget {
  final ReviewsCubit cubit;
  final int placeId;

  const AddReviewDialog({
    super.key,
    required this.cubit,
    required this.placeId,
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
      referenceType: 'Place',
      referenceId: widget.placeId,
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
    return AlertDialog(
      title: const Text('Write a Review'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Rate your experience'),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                onPressed: _isSubmitting
                    ? null
                    : () => setState(() => _rating = index + 1),
                icon: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
              );
            }),
          ),
          TextField(
            controller: _commentController,
            maxLines: 3,
            enabled: !_isSubmitting,
            decoration: const InputDecoration(
              hintText: 'Share your experience...',
              border: OutlineInputBorder(),
            ),
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
              : const Text('Submit'),
        ),
      ],
    );
  }
}
