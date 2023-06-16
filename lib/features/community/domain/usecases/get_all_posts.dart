import 'package:dartz/dartz.dart';
import 'package:tanitama/core/commons/failure.dart';
import 'package:tanitama/features/community/domain/entities/post_entity.dart';
import 'package:tanitama/features/community/domain/repositories/community_repository.dart';

class GetAllPosts {
  final CommunityRepository repository;

  GetAllPosts(this.repository);

  Future<Either<Failure, List<PostEntity>>> execute() {
    return repository.getAllPosts();
  }
}
