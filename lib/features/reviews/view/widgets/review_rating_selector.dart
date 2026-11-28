import 'package:flutter/material.dart';
import 'package:tourist_app/core/helpers/spacing.dart';

class ReviewRatingSelector extends StatelessWidget {
  final int rating;
  final ValueChanged<int> onChanged;
  final bool enabled;

  const ReviewRatingSelector({
    super.key,
    required this.rating,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          'Rate your experience',
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        verticalSpace(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return IconButton(
              onPressed: enabled ? () => onChanged(index + 1) : null,
              icon: Icon(
                index < rating
                    ? Icons.star_rounded
                    : Icons.star_outline_rounded,
                color: Colors.amber,
                size: 34,
              ),
            );
          }),
        ),
        Text(
          '$rating out of 5',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
        ),
      ],
    );
  }
}
