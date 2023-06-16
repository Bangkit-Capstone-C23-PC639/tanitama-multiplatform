import 'package:dartz/dartz.dart';
import 'package:tanitama/core/commons/failure.dart';
import 'package:tanitama/features/community/domain/entities/post_entity.dart';
import 'package:tanitama/features/community/domain/repositories/community_repository.dart';

class GetPostById {
  final CommunityRepository repository;

  GetPostById(this.repository);

  Future<Either<Failure, PostEntity>> execute(int id) {
    return repository.getPostById(id);
  }
}
