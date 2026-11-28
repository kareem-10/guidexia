import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tourist_app/core/helpers/spacing.dart';

class ReviewCard extends StatelessWidget {
  final String reviewerName;
  final String? reviewerImageUrl;
  final DateTime? reviewDate;
  final double rating;
  final String comment;
  final bool isOwner;
  final bool isDeleting;
  final VoidCallback onDelete;

  const ReviewCard({
    super.key,
    required this.reviewerName,
    required this.reviewerImageUrl,
    required this.reviewDate,
    required this.rating,
    required this.comment,
    required this.isOwner,
    required this.isDeleting,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final hasImage = reviewerImageUrl != null && reviewerImageUrl!.isNotEmpty;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: scheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.45)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: scheme.primary.withValues(alpha: 0.7),
                  backgroundImage: hasImage
                      ? CachedNetworkImageProvider(reviewerImageUrl!)
                      : null,
                  child: !hasImage
                      ? Icon(
                          Icons.person_outline,
                          color: scheme.onSecondaryContainer,
                        )
                      : null,
                ),
                horizontalSpace(11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reviewerName.isNotEmpty ? reviewerName : 'Anonymous',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (reviewDate != null) ...[
                        verticalSpace(3),
                        Text(
                          '${reviewDate!.day}/${reviewDate!.month}/${reviewDate!.year}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                      ],
                    ],
                  ),
                ),
                _RatingBadge(rating: rating),
                if (isOwner) ...[
                  horizontalSpace(4),
                  IconButton(
                    onPressed: isDeleting ? null : onDelete,
                    icon: const Icon(Icons.delete_outline_rounded),
                    color: scheme.error,
                    tooltip: 'Delete review',
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ],
            ),
            verticalSpace(14),
            Text(
              comment,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.55,
                color: scheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RatingBadge extends StatelessWidget {
  final double rating;

  const _RatingBadge({required this.rating});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: scheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, color: Colors.amber, size: 17),
          horizontalSpace(4),
          Text(
            rating.toStringAsFixed(1),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: scheme.onTertiaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
