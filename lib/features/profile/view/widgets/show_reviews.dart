import 'package:flutter/material.dart';
import 'package:tourist_app/core/utils/app_colors.dart';
import 'package:tourist_app/features/profile/data/models/profile_model.dart';
import 'package:tourist_app/features/profile/view/widgets/list_sheet.dart';

void showReviews(BuildContext context, List<ReviewModel> reviews) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => ListSheet(
      title: 'My Reviews',
      emptyText: 'You have not written any reviews yet.',
      isEmpty: reviews.isEmpty,
      children: reviews
          .map(
            (review) => ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(0xFFE7EDE4),
                child: Icon(
                  Icons.star_outline_rounded,
                  color: AppColors.primaryColor,
                ),
              ),
              title: Text(review.placeName),
              subtitle: Text('${review.comment}\n${review.date}'),
              isThreeLine: true,
              trailing: Text(
                '★ ${review.rating}',
                style: const TextStyle(color: Color(0xFFB47B45)),
              ),
            ),
          )
          .toList(),
    ),
  );
}
