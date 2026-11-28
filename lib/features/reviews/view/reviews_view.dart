import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/features/reviews/view/show_add_review_dialog.dart';
import 'package:tourist_app/features/reviews/view/widgets/confirm_delete.dart';
import 'package:tourist_app/features/reviews/view/widgets/review_card.dart';
import 'package:tourist_app/features/reviews/view/widgets/reviews_header.dart';
import 'package:tourist_app/features/reviews/view/widgets/reviews_message.dart';
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

    return BlocBuilder<ReviewsCubit, ReviewsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReviewsHeader(
              reviewsCount: state.reviews.length,
              isSubmitting: state.isSubmitting,
              onWriteReview: () => showAddReviewDialog(
                context,
                cubit,
                referenceType: referenceType,
                referenceId: referenceId,
              ),
            ),
            verticalSpace(18),
            if (state.status == ReviewsStatus.loading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Image(image: AssetImage('assets/images/loading.gif')),
                ),
              )
            else if (state.status == ReviewsStatus.failure)
              ReviewsMessage(
                icon: Icons.cloud_off_outlined,
                message: state.errorMessage ?? 'Something went wrong',
                actionLabel: 'Try Again',
                onAction: () => cubit.loadReviews(
                  referenceType: referenceType,
                  referenceId: referenceId,
                ),
              )
            else if (state.reviews.isEmpty)
              const ReviewsMessage(
                icon: Icons.rate_review_outlined,
                message:
                    'No reviews yet. Be the first to share your experience!',
              )
            else
              ...state.reviews.map(
                (review) => ReviewCard(
                  reviewerName: review.reviewerName,
                  reviewerImageUrl: review.reviewerImageUrl,
                  reviewDate: review.reviewDate,
                  rating: review.rating,
                  comment: review.comment,
                  isOwner: review.isOwner,
                  isDeleting: state.isDeleting,
                  onDelete: () => confirmDeleteReview(
                    context,
                    cubit,
                    referenceType: referenceType,
                    referenceId: referenceId,
                    reviewId: review.id,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
