import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tanitama/core/commons/constants.dart';
import 'package:tanitama/core/presentation/widgets/custom_button.dart';
import 'package:tanitama/core/presentation/widgets/cutom_text_field.dart';
import 'package:tanitama/features/community/presentation/cubit/community_cubit.dart';
import 'package:tanitama/features/community/presentation/cubit/create_post_cubit.dart';
import 'package:tanitama/features/community/presentation/cubit/post_image_picker_cubit.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({super.key});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Tanya Komunitas',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        leading: BackButton(
          onPressed: () {
            BlocProvider.of<PostImagePickerCubit>(context).removeImage();
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(largePadding),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child:
                        BlocBuilder<PostImagePickerCubit, PostImagePickerState>(
                      builder: (context, state) {
                        if (state is PostImagePickerSuccess) {
                          if (state.image != null) {
                            return InkWell(
                              onTap: () {
                                BlocProvider.of<PostImagePickerCubit>(context)
                                    .takePhotoFromGallery();
                              },
                              child: SizedBox(
                                width: double.infinity,
                                child: Image.file(
                                  File(state.image!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }
                        } else if (state is PostImagePickerError) {
                          return Center(
                            child: Text(
                              state.message,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          );
                        }

                        return InkWell(
                          onTap: () {
                            BlocProvider.of<PostImagePickerCubit>(context)
                                .takePhotoFromGallery();
                          },
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const FaIcon(FontAwesomeIcons.image),
                                const SizedBox(
                                  height: smallPadding,
                                ),
                                Text(
                                  'Tambahkan gambar',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: largePadding,
              ),
              CustomTextField(
                controller: _titleController,
                label: 'Judul',
              ),
              const SizedBox(
                height: largePadding,
              ),
              CustomTextField(
                controller: _descriptionController,
                label: 'Deskripsi',
                maxLines: 4,
              ),
              const Spacer(),
              BlocListener<CreatePostCubit, CreatePostState>(
                listener: (context, state) {
                  if (state is CreatePostLoading) {
                    EasyLoading.show(status: 'Menambahkan...');
                  } else if (state is CreatePostSuccess) {
                    BlocProvider.of<CommunityCubit>(context).fetchAllPosts();
                    BlocProvider.of<PostImagePickerCubit>(context)
                        .removeImage();
                    EasyLoading.showSuccess(state.message);
                    Navigator.pop(context);
                  } else if (state is CreatePostError) {
                    BlocProvider.of<PostImagePickerCubit>(context)
                        .removeImage();
                    EasyLoading.showError(state.message);
                    Navigator.pop(context);
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final state =
                            BlocProvider.of<PostImagePickerCubit>(context)
                                .state;

                        if (state is PostImagePickerSuccess &&
                            state.image != null) {
                          final imagePath = state.image!.path;

                          BlocProvider.of<CreatePostCubit>(context).addPost(
                            _titleController.text,
                            _descriptionController.text,
                            File(imagePath),
                          );
                        }
                      }
                    },
                    label: 'Tanya',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
