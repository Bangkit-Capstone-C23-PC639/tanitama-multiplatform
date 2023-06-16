import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tanitama/features/detection/domain/usecases/delete_detection_history.dart';

part 'delete_detection_history_state.dart';

class DeleteDetectionHistoryCubit extends Cubit<DeleteDetectionHistoryState> {
  DeleteDetectionHistoryCubit({
    required this.deleteDetectionHistory,
  }) : super(DeleteDetectionHistoryInitial());

  final DeleteDetectionHistory deleteDetectionHistory;

  void deleteDetection(String id) async {
    emit(DeleteDetectionHistoryLoading());

    final results = await deleteDetectionHistory.execute(id);

    results.fold(
      (failure) {
        emit(DeleteDetectionHistoryError(failure.message));
      },
      (data) {
        emit(DeleteDetectionHistorySuccess(data));
      },
    );
  }
}
