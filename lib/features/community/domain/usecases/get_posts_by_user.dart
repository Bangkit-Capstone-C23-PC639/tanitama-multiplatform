import 'package:dartz/dartz.dart';
import 'package:tanitama/core/commons/failure.dart';
import 'package:tanitama/features/community/domain/entities/post_entity.dart';
import 'package:tanitama/features/community/domain/repositories/community_repository.dart';

class GetPostsByUser {
  final CommunityRepository repository;

  GetPostsByUser(this.repository);

  Future<Either<Failure, List<PostEntity>>> execute() {
    return repository.getPostsByUser();
  }
}
