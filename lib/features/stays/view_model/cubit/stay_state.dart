import 'package:equatable/equatable.dart';
import '../../data/models/stay_model.dart';

abstract class StayState extends Equatable {
  const StayState();

  @override
  List<Object?> get props => [];
}

class StayInitial extends StayState {
  const StayInitial();
}

class StayLoading extends StayState {
  const StayLoading();
}

class StaySuccess extends StayState {
  final List<StayModel> stays;

  const StaySuccess(this.stays);

  @override
  List<Object?> get props => [stays];
}

class StayFailure extends StayState {
  final String message;

  const StayFailure(this.message);

  @override
  List<Object?> get props => [message];
}
