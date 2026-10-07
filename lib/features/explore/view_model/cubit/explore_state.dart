import 'package:equatable/equatable.dart';
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
  final List<PlaceModel> places;
  final String selectedCategory;

  const ExploreSuccess({required this.places, required this.selectedCategory});

  @override
  List<Object?> get props => [places, selectedCategory];
}

class ExploreFailure extends ExploreState {
  final String message;

  const ExploreFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
