import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tanitama/core/commons/constants.dart';
import 'package:tanitama/core/presentation/widgets/custom_button.dart';
import 'package:tanitama/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:tanitama/features/detection/domain/entities/detection_detail_entity.dart';
import 'package:tanitama/features/detection/presentation/cubit/detection_cubit.dart';
import 'package:tanitama/features/detection/presentation/cubit/image_picker_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).logout();
            },
            icon: const Icon(Icons.logout),
          )
        ],
        title: Text(
          'TaniTama',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: BlocListener<DetectionCubit, DetectionState>(
        listener: (context, state) {
          if (state is DetectionSuccess) {
            EasyLoading.dismiss();
            Navigator.pushNamed(
              context,
              detectionResultRoute,
              arguments: DetectionDetailEntity(
                type: 'result',
                detection: state.detection,
              ),
            );
          } else if (state is DetectionError) {
            EasyLoading.dismiss();
            Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            EasyLoading.show(status: "Menganalisa...");
            // Lottie.asset('assets/json/loading.json');
          }
        },
        child: Container(
          padding: const EdgeInsets.all(largePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'TaniTama\nIdentifikasi Penyakit Padi!',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(
                height: largePadding * 2,
              ),
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/padi.png'),
                radius: 60,
              ),
              const SizedBox(
                height: largePadding,
              ),
              Text(
                'Ambil Gambar',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: BlocListener<ImagePickerCubit, ImagePickerState>(
                        listener: (context, state) {
                          if (state is ImagePickerSuccess) {
                            if (state.image != null) {
                              BlocProvider.of<DetectionCubit>(context)
                                  .fetchDetection(File(state.image!.path));
                            }
                          } else if (state is ImagePickerError) {
                            Fluttertoast.showToast(
                                msg: state.error,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: CustomButton(
                            onPressed: () {
                              showMaterialModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          leading: const Icon(Icons.camera),
                                          title: Text(
                                            'Camera',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                          ),
                                          onTap: () {
                                            BlocProvider.of<ImagePickerCubit>(
                                                    context)
                                                .takePhotoFromCamera();
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          leading: const Icon(Icons.image),
                                          title: Text(
                                            'Gallery',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                          ),
                                          onTap: () {
                                            BlocProvider.of<ImagePickerCubit>(
                                                    context)
                                                .takePhotoFromGallery();
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  });
                            },
                            label: 'Ambil Gambar '),
                      )),
                  const SizedBox(
                    height: smallPadding,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                        onPressed: () {
                          Navigator.pushNamed(context, detectionHistoryRoute);
                        },
                        label: 'Hasil '),
                  ),
                  const SizedBox(
                    height: smallPadding,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                        onPressed: () {
                          Navigator.pushNamed(context, communityRoute);
                        },
                        label: 'Komunitas '),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
