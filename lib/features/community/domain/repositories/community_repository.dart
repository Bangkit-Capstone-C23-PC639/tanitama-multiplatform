import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tanitama/core/commons/failure.dart';
import 'package:tanitama/features/community/domain/entities/post_entity.dart';

abstract class CommunityRepository {
  Future<Either<Failure, List<PostEntity>>> getAllPosts();
  Future<Either<Failure, PostEntity>> getPostById(int id);
  Future<Either<Failure, List<PostEntity>>> getPostsByUser();
  Future<Either<Failure, String>> createComment(int id, String content);
  Future<Either<Failure, String>> createPost(
      String title, String content, File image);
  Future<Either<Failure, String>> deletePost(int id);
  Future<Either<Failure, String>> deleteComment(int id);
}
