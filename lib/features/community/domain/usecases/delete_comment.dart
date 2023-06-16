import 'package:dartz/dartz.dart';
import 'package:tanitama/core/commons/failure.dart';
import 'package:tanitama/features/community/domain/repositories/community_repository.dart';

class DeleteComment {
  final CommunityRepository repository;

  DeleteComment(this.repository);

  Future<Either<Failure, String>> execute(int id) {
    return repository.deleteComment(id);
  }
}
