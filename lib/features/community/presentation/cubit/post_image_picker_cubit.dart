import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

part 'post_image_picker_state.dart';

class PostImagePickerCubit extends Cubit<PostImagePickerState> {
  PostImagePickerCubit() : super(PostImagePickerInitial());

  final ImagePicker picker = ImagePicker();

  void takePhotoFromCamera() async {
    emit(PostImagePickerLoading());

    try {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      emit(PostImagePickerSuccess(image));
    } on PlatformException catch (e) {
      emit(PostImagePickerError('Failed to pick image: $e'));
    }
  }

  void takePhotoFromGallery() async {
    emit(PostImagePickerLoading());

    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      emit(PostImagePickerSuccess(image));
    } on PlatformException catch (e) {
      emit(PostImagePickerError('Failed to pick image: $e'));
    }
  }

  void removeImage() async {
    emit(PostImagePickerInitial());
  }
}
