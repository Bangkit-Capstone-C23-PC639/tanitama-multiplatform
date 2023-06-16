import 'package:dartz/dartz.dart';
import 'package:tanitama/core/commons/failure.dart';
import 'package:tanitama/features/community/domain/repositories/community_repository.dart';

class CreateComment {
  final CommunityRepository repository;

  CreateComment(this.repository);

  Future<Either<Failure, String>> execute(int id, String content) {
    return repository.createComment(id, content);
  }
}
