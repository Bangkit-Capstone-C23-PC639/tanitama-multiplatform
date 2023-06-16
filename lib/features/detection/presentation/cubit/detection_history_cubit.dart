import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tanitama/features/detection/domain/entities/detection_entity.dart';
import 'package:tanitama/features/detection/domain/usecases/get_detection_history.dart';

part 'detection_history_state.dart';

class DetectionHistoryCubit extends Cubit<DetectionHistoryState> {
  DetectionHistoryCubit({required this.getDetectionHistory})
      : super(DetectionHistoryInitial());

  final GetDetectionHistory getDetectionHistory;

  void fetchDetectionHistory() async {
    emit(DetectionHistoryLoading());

    final results = await getDetectionHistory.execute();

    results.fold(
      (failure) {
        emit(DetectionHistoryError(failure.message));
      },
      (data) {
        emit(DetectionHistorySuccess(data));
      },
    );
  }
}
