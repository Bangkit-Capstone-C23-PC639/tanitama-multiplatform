import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit() : super(ImagePickerInitial());

  final ImagePicker picker = ImagePicker();

  void takePhotoFromCamera() async {
    emit(ImagePickerLoading());

    try {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      emit(ImagePickerSuccess(image));
    } on PlatformException catch (e) {
      emit(ImagePickerError('Failed to pick image: $e'));
    }
  }

  void takePhotoFromGallery() async {
    emit(ImagePickerLoading());

    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      emit(ImagePickerSuccess(image));
    } on PlatformException catch (e) {
      emit(ImagePickerError('Failed to pick image: $e'));
    }
  }
}
