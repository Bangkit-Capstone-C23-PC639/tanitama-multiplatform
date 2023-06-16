import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tanitama/core/commons/constants.dart';
import 'package:tanitama/features/detection/domain/entities/detection_detail_entity.dart';
import 'package:tanitama/features/detection/presentation/cubit/delete_detection_history_cubit.dart';
import 'package:tanitama/features/detection/presentation/cubit/detection_history_cubit.dart';

class DetectionResultScreen extends StatelessWidget {
  const DetectionResultScreen({
    super.key,
    required this.data,
  });

  final DetectionDetailEntity data;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));

    return Scaffold(
      backgroundColor: const Color(0xFFC9DCBD),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(largePadding),
          child: Column(
            children: [
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: const Color(0XFFA7BB99),
                            foregroundColor: Colors.red,
                          ),
                          child: const FaIcon(
                            FontAwesomeIcons.xmark,
                            color: Colors.white,
                          ),
                        ),
                        data.type == 'history'
                            ? BlocListener<DeleteDetectionHistoryCubit,
                                DeleteDetectionHistoryState>(
                                listener: (context, state) {
                                  if (state is DeleteDetectionHistoryLoading) {
                                    EasyLoading.show(status: 'Menghapus...');
                                  } else if (state
                                      is DeleteDetectionHistoryError) {
                                    Fluttertoast.showToast(
                                        msg: state.message,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else if (state
                                      is DeleteDetectionHistorySuccess) {
                                    BlocProvider.of<DetectionHistoryCubit>(
                                            context)
                                        .fetchDetectionHistory();
                                    EasyLoading.showSuccess(state.result);
                                    Navigator.pop(context);
                                  }
                                },
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      useSafeArea: true,
                                      builder: (context) => AlertDialog(
                                        backgroundColor: Colors.white,
                                        surfaceTintColor: Colors.white,
                                        title: Text(
                                          'Hapus riwayat',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                        ),
                                        content: Text(
                                          'Anda yakin ingin menghapus?',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                        actions: [
                                          FilledButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: FilledButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  elevation: 1),
                                              child: Text(
                                                'Batal',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              )),
                                          FilledButton(
                                              onPressed: () {
                                                BlocProvider.of<
                                                            DeleteDetectionHistoryCubit>(
                                                        context)
                                                    .deleteDetection(data
                                                        .detection.id
                                                        .toString());
                                                Navigator.pop(context);
                                              },
                                              style: FilledButton.styleFrom(
                                                backgroundColor:
                                                    Colors.red.shade400,
                                              ),
                                              child: Text(
                                                'Hapus',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      color: Colors.white,
                                                    ),
                                              )),
                                        ],
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    backgroundColor: const Color(0XFFA7BB99),
                                    foregroundColor: Colors.red,
                                  ),
                                  child: const FaIcon(
                                    FontAwesomeIcons.trash,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                    const SizedBox(
                      height: largePadding * 1.5,
                    ),
                    Text(
                      data.detection.disease.name,
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(
                      height: smallPadding,
                    ),
                    Text(
                      'Akurasi: ${data.detection.accuracy.toString()} %',
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(
                      height: largePadding * 1.5,
                    ),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      clipBehavior: Clip.none,
                      children: [
                        CachedNetworkImage(
                          imageUrl: data.detection.imageUrl,
                          fit: BoxFit.cover,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.width / 1.5,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    alignment: FractionalOffset.center,
                                    image: imageProvider,
                                  )),
                            );
                          },
                          placeholder: (context, url) => SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.width / 1.5,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.width / 1.5,
                            child: const Center(child: Icon(Icons.error)),
                          ),
                        ),
                        Positioned(
                          bottom: -57,
                          child: GestureDetector(
                            onTap: () {
                              showBarModalBottomSheet(
                                  context: context,
                                  duration: const Duration(milliseconds: 100),
                                  builder: (context) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: largePadding,
                                        vertical: largePadding * 3,
                                      ),
                                      child: Text(
                                          data.detection.disease.recomendation,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                    );
                                  });
                            },
                            child: AvatarGlow(
                              child: Container(
                                padding: const EdgeInsets.all(smallPadding),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: FaIcon(
                                  FontAwesomeIcons.circleExclamation,
                                  color: Color(0XFF4f5c47),
                                ),
                              ),
                              endRadius: 60.0,
                              duration: Duration(milliseconds: 2000),
                              repeat: true,
                              showTwoGlows: true,
                              glowColor: Color(0xFFC9DCBD),
                              repeatPauseDuration: Duration(milliseconds: 100),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: largePadding * 1.5,
                    ),
                    Container(
                      padding: const EdgeInsets.all(basePadding),
                      decoration: const BoxDecoration(
                        color: Color(0XFFDCE8D4),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: Text(
                        data.detection.disease.description,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
