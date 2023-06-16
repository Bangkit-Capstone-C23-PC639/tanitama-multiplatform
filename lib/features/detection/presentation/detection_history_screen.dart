import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tanitama/core/commons/constants.dart';
import 'package:tanitama/features/detection/domain/entities/detection_detail_entity.dart';
import 'package:tanitama/features/detection/presentation/cubit/detection_history_cubit.dart';
import 'package:tanitama/features/detection/presentation/widgets/detection_history_item.dart';

class DetectionHistoryScreen extends StatefulWidget {
  const DetectionHistoryScreen({super.key});

  @override
  State<DetectionHistoryScreen> createState() => _DetectionHistoryScreenState();
}

class _DetectionHistoryScreenState extends State<DetectionHistoryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DetectionHistoryCubit>(context).fetchDetectionHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Riwayat',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<DetectionHistoryCubit, DetectionHistoryState>(
        builder: (context, state) {
          if (state is DetectionHistorySuccess) {
            return GridView.builder(
              padding: const EdgeInsets.all(largePadding),
              itemCount: state.detection.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 9 / 12),
              itemBuilder: (context, index) => DetectionHistoryItem(
                detection: state.detection[index],
              ),
            );
          } else if (state is DetectionHistoryError) {
            Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
