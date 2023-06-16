part of 'post_image_picker_cubit.dart';

abstract class PostImagePickerState extends Equatable {
  const PostImagePickerState();

  @override
  List<Object> get props => [];
}

class PostImagePickerInitial extends PostImagePickerState {}

class PostImagePickerLoading extends PostImagePickerState {}

class PostImagePickerError extends PostImagePickerState {
  final String message;

  const PostImagePickerError(this.message);

  @override
  List<Object> get props => [message];
}

class PostImagePickerSuccess extends PostImagePickerState {
  final XFile? image;

  const PostImagePickerSuccess(this.image);
}
