import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/core/di/dependancy_injection.dart';
import 'package:tourist_app/features/reviews/view/reviews_view.dart';
import 'package:tourist_app/features/reviews/view_model/cubit/reviews_cubit.dart';

class ReviewsSection extends StatelessWidget {
  final String referenceType;
  final int referenceId;

  const ReviewsSection({
    super.key,
    required this.referenceType,
    required this.referenceId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ReviewsCubit>()
        ..loadReviews(referenceType: referenceType, referenceId: referenceId),
      child: ReviewsView(
        referenceType: referenceType,
        referenceId: referenceId,
      ),
    );
  }
}
