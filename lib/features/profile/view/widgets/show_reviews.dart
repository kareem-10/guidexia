import 'package:flutter/material.dart';
import 'package:tourist_app/features/profile/data/models/profile_model.dart';
import 'package:tourist_app/features/profile/view/widgets/list_sheet.dart';

void showReviews(BuildContext context, List<ReviewModel> reviews) {
  final scheme = Theme.of(context).colorScheme;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: scheme.surface,
    builder: (_) => ListSheet(
      title: 'My Reviews',
      emptyText: 'You have not written any reviews yet.',
      isEmpty: reviews.isEmpty,
      children: reviews
          .map(
            (review) => ListTile(
              leading: CircleAvatar(
                backgroundColor: scheme.surfaceContainerHighest,
                child: Icon(Icons.star_outline_rounded, color: scheme.primary),
              ),
              title: Text(review.placeName),
              subtitle: Text('${review.comment}\n${review.date}'),
              isThreeLine: true,
              trailing: Text(
                '★ ${review.rating}',
                style: TextStyle(color: scheme.tertiary),
              ),
            ),
          )
          .toList(),
    ),
  );
}
