import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tanitama/core/commons/constants.dart';
import 'package:tanitama/core/commons/exception.dart';
import 'package:tanitama/features/detection/data/models/detection_history_response.dart';
import 'package:tanitama/features/detection/data/models/detection_model.dart';
import 'package:tanitama/features/detection/data/models/detection_response.dart';

abstract class DetectionRemoteDataSource {
  Future<DetectionModel> detection(File image);
  Future<List<DetectionModel>> detectionHistory();
  Future<String> deleteDetectionHistory(String id);
}

class DetectionRemoteDataSourceImpl implements DetectionRemoteDataSource {
  final http.Client client;
  final FlutterSecureStorage storage;

  DetectionRemoteDataSourceImpl({required this.client, required this.storage});

  @override
  Future<DetectionModel> detection(File image) async {
    final String? token = await storage.read(key: 'access-token');

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrlApi/detections'),
    );

    request.headers["Authorization"] = 'Bearer $token';
    request.files.add(http.MultipartFile(
        'file', image.readAsBytes().asStream(), image.lengthSync(),
        filename: image.path.split('/').last));

    final streamRes = await request.send();
    final response = await http.Response.fromStream(streamRes);

    if (response.statusCode == 201) {
      return DetectionResponse.fromJson(jsonDecode(response.body))
          .detectionModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<DetectionModel>> detectionHistory() async {
    final String? token = await storage.read(key: 'access-token');

    final response = await client.get(
      Uri.parse('$baseUrlApi/history'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return DetectionHistoryResponse.fromJson(jsonDecode(response.body))
          .detectionModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> deleteDetectionHistory(String id) async {
    final String? token = await storage.read(key: 'access-token');

    final response = await client.delete(
      Uri.parse('$baseUrlApi/detections/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": 'Bearer $token'
      },
    );

    if (response.statusCode == 204) {
      return 'Berhasil menghapus';
    } else {
      throw ServerException();
    }
  }
}
