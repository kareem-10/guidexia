import 'package:flutter/material.dart';
import 'package:tourist_app/core/helpers/spacing.dart';

class ReviewsHeader extends StatelessWidget {
  final int reviewsCount;
  final bool isSubmitting;
  final VoidCallback onWriteReview;

  const ReviewsHeader({
    super.key,
    required this.reviewsCount,
    required this.isSubmitting,
    required this.onWriteReview,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Guest Reviews',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              verticalSpace(4),
              Text(
                '$reviewsCount reviews from visitors',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
        FilledButton.tonalIcon(
          onPressed: isSubmitting ? null : onWriteReview,
          icon: const Icon(Icons.edit_outlined, size: 17),
          label: const Text('Write a Review'),
          style: FilledButton.styleFrom(
            backgroundColor: scheme.primary.withValues(alpha: .7),
          ),
        ),
      ],
    );
  }
}
