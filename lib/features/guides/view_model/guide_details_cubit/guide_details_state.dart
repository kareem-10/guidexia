import 'package:equatable/equatable.dart';
import 'package:tourist_app/features/guides/data/models/guide_model.dart';

abstract class GuideDetailsState extends Equatable {
  const GuideDetailsState();

  @override
  List<Object?> get props => [];
}

class GuideDetailsInitial extends GuideDetailsState {
  const GuideDetailsInitial();
}

class GuideDetailsLoading extends GuideDetailsState {
  const GuideDetailsLoading();
}

class GuideDetailsSuccess extends GuideDetailsState {
  final GuideModel guide;

  const GuideDetailsSuccess(this.guide);

  @override
  List<Object?> get props => [guide];
}

class GuideDetailsFailure extends GuideDetailsState {
  final String message;

  const GuideDetailsFailure(this.message);

  @override
  List<Object?> get props => [message];
}
