import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/features/reviews/view/confirm_delete.dart';
import 'package:tourist_app/features/reviews/view/show_add_review_dialog.dart';
import 'package:tourist_app/features/reviews/view_model/cubit/reviews_cubit.dart';
import 'package:tourist_app/features/reviews/view_model/cubit/reviews_state.dart';

class ReviewsView extends StatelessWidget {
  final String referenceType;
  final int referenceId;
  const ReviewsView({
    super.key,
    required this.referenceType,
    required this.referenceId,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReviewsCubit>();
    final scheme = Theme.of(context).colorScheme;
    return BlocBuilder<ReviewsCubit, ReviewsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reviews (${state.reviews.length})',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton.icon(
                  onPressed: state.isSubmitting
                      ? null
                      : () => showAddReviewDialog(
                          context,
                          cubit,
                          referenceType: referenceType,
                          referenceId: referenceId,
                        ),
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text('Write a Review'),
                ),
              ],
            ),
            verticalSpace(12),
            if (state.status == ReviewsStatus.loading)
              const Center(
                child: Image(image: AssetImage('assets/images/loading.gif')),
              )
            else if (state.status == ReviewsStatus.failure)
              Center(
                child: Column(
                  children: [
                    Text(
                      state.errorMessage ?? 'Something went wrong',
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {
                        cubit.loadReviews(
                          referenceType: referenceType,
                          referenceId: referenceId,
                        );
                      },
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              )
            else if (state.reviews.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('No reviews yet. Be the first to review!'),
                ),
              )
            else
              ...state.reviews.map(
                (review) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: scheme.primaryContainer,
                              child: Icon(
                                Icons.person_outline,
                                color: scheme.onPrimaryContainer,
                              ),
                            ),
                            horizontalSpace(10),
                            Expanded(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      review.reviewerName.isNotEmpty
                                          ? review.reviewerName
                                          : 'Anonymous',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    '(${review.rating.toStringAsFixed(1)})',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: state.isDeleting
                                  ? null
                                  : () => confirmDeleteReview(
                                      context,
                                      cubit,
                                      referenceType: referenceType,
                                      referenceId: referenceId,
                                      reviewId: review.id,
                                    ),
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              tooltip: 'Delete review',
                              visualDensity: VisualDensity.compact,
                            ),
                          ],
                        ),

                        verticalSpace(10),
                        Text(review.comment),
                        if (review.reviewDate != null) ...[
                          verticalSpace(8),
                          Text(
                            '${review.reviewDate!.day}/${review.reviewDate!.month}/${review.reviewDate!.year}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
