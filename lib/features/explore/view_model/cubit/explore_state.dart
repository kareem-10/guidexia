import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tourist_app/features/explore/data/models/place_model.dart';

abstract class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object?> get props => [];
}

class ExploreInitial extends ExploreState {
  const ExploreInitial();
}

class ExploreLoading extends ExploreState {
  const ExploreLoading();
}

class ExploreSuccess extends ExploreState {
  final PagingState<int, PlaceModel> pagingState;
  final String selectedCategory;
  final String searchQuery;

  const ExploreSuccess({
    required this.pagingState,
    required this.selectedCategory,
    required this.searchQuery,
  });

  List<PlaceModel> get places =>
      pagingState.pages?.expand((page) => page).toList() ?? [];

  @override
  List<Object?> get props => [pagingState, selectedCategory, searchQuery];
}

class ExploreFailure extends ExploreState {
  final String message;

  const ExploreFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
