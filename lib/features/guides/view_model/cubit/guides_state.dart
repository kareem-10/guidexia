import 'package:equatable/equatable.dart';
import '../../data/models/guide_model.dart';

abstract class GuidesState extends Equatable {
  const GuidesState();
  @override
  List<Object?> get props => [];
}

class GuidesInitial extends GuidesState {
  const GuidesInitial();
}

class GuidesLoading extends GuidesState {
  const GuidesLoading();
}

class GuidesSuccess extends GuidesState {
  final List<GuideModel> guides;
  final Set<int> favoriteIds;
  const GuidesSuccess(this.guides, this.favoriteIds);
  @override
  List<Object?> get props => [guides, favoriteIds];
}

class GuidesFailure extends GuidesState {
  final String message;
  const GuidesFailure(this.message);
  @override
  List<Object?> get props => [message];
}
