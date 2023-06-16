import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tanitama/features/detection/domain/entities/detection_entity.dart';

import 'package:tanitama/features/detection/domain/usecases/get_detection.dart';

part 'detection_state.dart';

class DetectionCubit extends Cubit<DetectionState> {
  DetectionCubit({required this.getDetection}) : super(DetectionInitial());

  final GetDetection getDetection;

  void fetchDetection(File image) async {
    emit(DetectionLoading());

    final results = await getDetection.execute(image);

    results.fold(
      (failure) {
        emit(DetectionError(failure.message));
      },
      (data) {
        emit(DetectionSuccess(data));
      },
    );
  }
}
