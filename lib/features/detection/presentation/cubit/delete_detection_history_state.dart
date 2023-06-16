part of 'delete_detection_history_cubit.dart';

abstract class DeleteDetectionHistoryState extends Equatable {
  const DeleteDetectionHistoryState();

  @override
  List<Object> get props => [];
}

class DeleteDetectionHistoryInitial extends DeleteDetectionHistoryState {}

class DeleteDetectionHistoryLoading extends DeleteDetectionHistoryState {}

class DeleteDetectionHistoryError extends DeleteDetectionHistoryState {
  final String message;

  const DeleteDetectionHistoryError(this.message);

  @override
  List<Object> get props => [message];
}

class DeleteDetectionHistorySuccess extends DeleteDetectionHistoryState {
  final String result;

  const DeleteDetectionHistorySuccess(this.result);

  @override
  List<Object> get props => [result];
}
