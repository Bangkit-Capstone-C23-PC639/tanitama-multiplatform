import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tanitama/core/commons/failure.dart';
import 'package:tanitama/features/community/domain/repositories/community_repository.dart';

class CreatePost {
  final CommunityRepository repository;

  CreatePost(this.repository);

  Future<Either<Failure, String>> execute(
      String title, String content, File image) {
    return repository.createPost(title, content, image);
  }
}
