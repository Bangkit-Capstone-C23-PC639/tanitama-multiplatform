part of 'detection_cubit.dart';

abstract class DetectionState extends Equatable {
  const DetectionState();

  @override
  List<Object> get props => [];
}

class DetectionInitial extends DetectionState {}

class DetectionLoading extends DetectionState {}

class DetectionError extends DetectionState {
  final String message;

  const DetectionError(this.message);

  @override
  List<Object> get props => [message];
}

class DetectionSuccess extends DetectionState {
  final DetectionEntity detection;

  const DetectionSuccess(this.detection);

  @override
  List<Object> get props => [detection];
}
