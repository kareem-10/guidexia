import 'package:equatable/equatable.dart';
import 'package:tourist_app/features/explore/data/models/place_model.dart';
import 'package:tourist_app/features/guides/data/models/guide_model.dart';
import 'package:tourist_app/features/stays/data/models/stay_model.dart';
import 'package:tourist_app/features/saved/data/models/saved_model.dart';

abstract class SavedState extends Equatable {
  const SavedState();

  @override
  List<Object?> get props => [];
}

class SavedInitial extends SavedState {
  const SavedInitial();
}

class SavedLoading extends SavedState {
  const SavedLoading();
}

class SavedSuccess extends SavedState {
  final List<SavedModel> saves;
  final List<PlaceModel> places;
  final List<GuideModel> guides;
  final List<StayModel> stays;

  const SavedSuccess({
    required this.saves,
    required this.places,
    required this.guides,
    required this.stays,
  });

  @override
  List<Object?> get props => [saves, places, guides, stays];
}

class SavedFailure extends SavedState {
  final String message;

  const SavedFailure(this.message);

  @override
  List<Object?> get props => [message];
}
