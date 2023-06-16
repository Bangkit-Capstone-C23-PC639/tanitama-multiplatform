import 'package:dartz/dartz.dart';
import 'package:tanitama/core/commons/failure.dart';
import 'package:tanitama/features/community/domain/repositories/community_repository.dart';

class DeletePost {
  final CommunityRepository repository;

  DeletePost(this.repository);

  Future<Either<Failure, String>> execute(int id) {
    return repository.deletePost(id);
  }
}
