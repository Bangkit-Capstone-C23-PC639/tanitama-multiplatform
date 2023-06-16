import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tanitama/core/commons/constants.dart';
import 'package:tanitama/features/detection/domain/entities/detection_detail_entity.dart';
import 'package:tanitama/features/detection/domain/entities/detection_entity.dart';

class DetectionHistoryItem extends StatelessWidget {
  const DetectionHistoryItem({
    super.key,
    required this.detection,
  });

  final DetectionEntity detection;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          detectionResultRoute,
          arguments:
              DetectionDetailEntity(type: 'history', detection: detection),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(smallPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: detection.imageUrl,
              fit: BoxFit.cover,
              imageBuilder: (context, imageProvider) {
                return Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        alignment: FractionalOffset.center,
                        image: imageProvider,
                      )),
                );
              },
              placeholder: (context, url) => const SizedBox(
                width: double.infinity,
                height: 100,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => const SizedBox(
                width: double.infinity,
                height: 100,
                child: Center(child: Icon(Icons.error)),
              ),
            ),
            const SizedBox(
              height: smallPadding,
            ),
            Text(
              'Akurasi: ${detection.accuracy}%',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Expanded(
              child: Text(
                detection.disease.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
