part of 'image_picker_cubit.dart';

abstract class ImagePickerState extends Equatable {
  const ImagePickerState();

  @override
  List<Object> get props => [];
}

class ImagePickerInitial extends ImagePickerState {}

class ImagePickerLoading extends ImagePickerState {}

class ImagePickerError extends ImagePickerState {
  final String error;

  const ImagePickerError(this.error);

  @override
  List<Object> get props => [error];
}

class ImagePickerSuccess extends ImagePickerState {
  final XFile? image;

  const ImagePickerSuccess(this.image);
}
