import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:tanitama/core/commons/constants.dart';
import 'package:tanitama/core/commons/exception.dart';
import 'package:tanitama/features/community/data/models/post_model.dart';
import 'package:http/http.dart' as http;
import 'package:tanitama/features/community/data/models/post_response.dart';
import 'package:tanitama/features/community/data/models/posts_response.dart';

abstract class CommunityRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<List<PostModel>> getPostsByUser();
  Future<PostModel> getPostById(int id);
  Future<String> createComment(int id, String content);
  Future<String> createPost(String title, String content, File image);
  Future<String> deletePost(int id);
}

class CommunityRemoteDataSourceImpl implements CommunityRemoteDataSource {
  final http.Client client;
  final FlutterSecureStorage storage;

  var logger = Logger();

  CommunityRemoteDataSourceImpl({required this.client, required this.storage});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(Uri.parse('$baseUrlApi/posts'), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    });

    if (response.statusCode == 200) {
      return PostsResponse.fromJson(jsonDecode(response.body)).posts;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PostModel> getPostById(int id) async {
    final response = await client.get(Uri.parse('$baseUrlApi/posts/$id'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        });

    if (response.statusCode == 200) {
      return PostResponse.fromJson(jsonDecode(response.body)).post;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> createComment(int id, String comment) async {
    final String? token = await storage.read(key: 'access-token');

    final body = json.encode({
      "content": comment,
    });

    final response =
        await client.post(Uri.parse('$baseUrlApi/posts/$id/comment'),
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": 'Bearer $token'
            },
            body: body);

    if (response.statusCode == 201) {
      return 'Berhasil menambahkan komentar';
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> createPost(String title, String content, File image) async {
    final String? token = await storage.read(key: 'access-token');

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrlApi/posts'),
    );

    request.headers["Authorization"] = 'Bearer $token';
    request.fields['title'] = title;
    request.fields['content'] = content;
    request.files.add(http.MultipartFile(
        'file', image.readAsBytes().asStream(), image.lengthSync(),
        filename: image.path.split('/').last));

    final streamRes = await request.send();
    final response = await http.Response.fromStream(streamRes);

    logger.d(response.statusCode);
    logger.d(response.body);

    if (response.statusCode == 201) {
      return "Berhasil menambahkan";
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> getPostsByUser() async {
    final String? token = await storage.read(key: 'access-token');

    final response =
        await client.get(Uri.parse('$baseUrlApi/myposts'), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    });

    logger.d(response.body);

    if (response.statusCode == 200) {
      return PostsResponse.fromJson(jsonDecode(response.body)).posts;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> deletePost(int id) async {
    final String? token = await storage.read(key: 'access-token');

    final response =
        await client.delete(Uri.parse('$baseUrlApi/posts/$id'), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    });

    logger.d(id);
    logger.d(response.statusCode);
    logger.d(response.body);

    if (response.statusCode == 204) {
      return "Berhasil menghapus post";
    } else {
      throw ServerException();
    }
  }
}
