part of 'detection_history_cubit.dart';

abstract class DetectionHistoryState extends Equatable {
  const DetectionHistoryState();

  @override
  List<Object> get props => [];
}

class DetectionHistoryInitial extends DetectionHistoryState {}

class DetectionHistoryLoading extends DetectionHistoryState {}

class DetectionHistoryError extends DetectionHistoryState {
  final String message;

  const DetectionHistoryError(this.message);

  @override
  List<Object> get props => [message];
}

class DetectionHistorySuccess extends DetectionHistoryState {
  final List<DetectionEntity> detection;

  const DetectionHistorySuccess(this.detection);

  @override
  List<Object> get props => [detection];
}
