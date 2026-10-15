import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/stay_repository.dart';
import 'stay_state.dart';

class StayCubit extends Cubit<StayState> {
  final StayRepository repository;

  StayCubit(this.repository) : super(const StayInitial());

  Future<void> getStays() async {
    emit(const StayLoading());

    try {
      final stays = await repository.getStays();
      emit(StaySuccess(stays));
    } catch (_) {
      emit(const StayFailure('Something went wrong. Please try again.'));
    }
  }
}
