import 'package:equatable/equatable.dart';
import 'package:tourist_app/features/place_details/data/models/activity_model.dart';

abstract class PlaceDetailsState extends Equatable {
  const PlaceDetailsState();

  @override
  List<Object?> get props => [];
}

class PlaceDetailsInitial extends PlaceDetailsState {
  const PlaceDetailsInitial();
}

class ActivitiesLoading extends PlaceDetailsState {
  const ActivitiesLoading();
}

class ActivitiesSuccess extends PlaceDetailsState {
  final List<ActivityModel> activities;

  const ActivitiesSuccess(this.activities);

  @override
  List<Object?> get props => [activities];
}

class ActivitiesFailure extends PlaceDetailsState {
  final String message;

  const ActivitiesFailure(this.message);

  @override
  List<Object?> get props => [message];
}
