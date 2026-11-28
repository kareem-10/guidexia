import 'package:flutter/material.dart';
import 'package:tourist_app/features/reviews/view/widgets/add_review_dialog.dart';
import 'package:tourist_app/features/reviews/view_model/cubit/reviews_cubit.dart';

void showAddReviewDialog(
  BuildContext context,
  ReviewsCubit cubit, {
  required String referenceType,
  required int referenceId,
}) {
  showDialog(
    context: context,
    builder: (_) => AddReviewDialog(
      cubit: cubit,
      referenceType: referenceType,
      referenceId: referenceId,
    ),
  );
}
