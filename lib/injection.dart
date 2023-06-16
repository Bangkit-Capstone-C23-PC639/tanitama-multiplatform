import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:tanitama/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:tanitama/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tanitama/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tanitama/features/auth/domain/repositories/auth_repository.dart';
import 'package:tanitama/features/auth/domain/usecases/auth_login.dart';
import 'package:tanitama/features/auth/domain/usecases/auth_logout.dart';
import 'package:tanitama/features/auth/domain/usecases/auth_register.dart';
import 'package:tanitama/features/auth/domain/usecases/get_token.dart';
import 'package:tanitama/features/auth/domain/usecases/save_token.dart';
import 'package:tanitama/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:tanitama/features/community/data/datasources/community_remote_data_source.dart';
import 'package:tanitama/features/community/data/repositories/community_repository_impl.dart';
import 'package:tanitama/features/community/domain/repositories/community_repository.dart';
import 'package:tanitama/features/community/domain/usecases/create_comment.dart';
import 'package:tanitama/features/community/domain/usecases/create_post.dart';
import 'package:tanitama/features/community/domain/usecases/delete_comment.dart';
import 'package:tanitama/features/community/domain/usecases/delete_post.dart';
import 'package:tanitama/features/community/domain/usecases/get_all_posts.dart';
import 'package:tanitama/features/community/domain/usecases/get_post_by_id.dart';
import 'package:tanitama/features/community/domain/usecases/get_posts_by_user.dart';
import 'package:tanitama/features/community/presentation/cubit/community_cubit.dart';
import 'package:tanitama/features/community/presentation/cubit/create_comment_cubit.dart';
import 'package:tanitama/features/community/presentation/cubit/create_post_cubit.dart';
import 'package:tanitama/features/community/presentation/cubit/delete_comment_cubit.dart';
import 'package:tanitama/features/community/presentation/cubit/delete_post_cubit.dart';
import 'package:tanitama/features/community/presentation/cubit/post_detail_cubit.dart';
import 'package:tanitama/features/community/presentation/cubit/post_image_picker_cubit.dart';
import 'package:tanitama/features/community/presentation/cubit/user_posts_cubit.dart';
import 'package:tanitama/features/detection/data/datasources/detection_remote_data_source.dart';
import 'package:tanitama/features/detection/data/repositories/detection_repository_impl.dart';
import 'package:tanitama/features/detection/domain/repositories/detection_repository.dart';
import 'package:tanitama/features/detection/domain/usecases/delete_detection_history.dart';
import 'package:tanitama/features/detection/domain/usecases/get_detection.dart';
import 'package:tanitama/features/detection/domain/usecases/get_detection_history.dart';
import 'package:tanitama/features/detection/presentation/cubit/delete_detection_history_cubit.dart';
import 'package:tanitama/features/detection/presentation/cubit/detection_cubit.dart';
import 'package:tanitama/features/detection/presentation/cubit/detection_history_cubit.dart';

import 'features/detection/presentation/cubit/image_picker_cubit.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(() => AuthCubit(
      authLogin: locator(),
      authRegister: locator(),
      saveToken: locator(),
      getToken: locator(),
      authLogout: locator()));
  locator.registerFactory(() => DetectionCubit(
        getDetection: locator(),
      ));
  locator.registerFactory(() => DetectionHistoryCubit(
        getDetectionHistory: locator(),
      ));
  locator.registerFactory(() => DeleteDetectionHistoryCubit(
        deleteDetectionHistory: locator(),
      ));
  locator.registerFactory(() => CommunityCubit(
        getAllPosts: locator(),
      ));
  locator.registerFactory(
      () => PostDetailCubit(getPostById: locator(), getToken: locator()));
  locator.registerFactory(() => CreateCommentCubit(
        createComment: locator(),
      ));
  locator.registerFactory(() => UserPostsCubit(
        getPostsByUser: locator(),
      ));
  locator.registerFactory(() => CreatePostCubit(
        createPost: locator(),
      ));
  locator.registerFactory(() => DeletePostCubit(
        deletePost: locator(),
      ));
  locator.registerFactory(() => DeleteCommentCubit(
        deleteComment: locator(),
      ));
  locator.registerFactory(() => ImagePickerCubit());
  locator.registerFactory(() => PostImagePickerCubit());

  locator.registerLazySingleton(() => AuthLogin(locator()));
  locator.registerLazySingleton(() => AuthRegister(locator()));
  locator.registerLazySingleton(() => AuthLogout(locator()));
  locator.registerLazySingleton(() => GetToken(locator()));
  locator.registerLazySingleton(() => SaveToken(locator()));
  locator.registerLazySingleton(() => GetDetection(locator()));
  locator.registerLazySingleton(() => GetDetectionHistory(locator()));
  locator.registerLazySingleton(() => DeleteDetectionHistory(locator()));
  locator.registerLazySingleton(() => GetAllPosts(locator()));
  locator.registerLazySingleton(() => GetPostById(locator()));
  locator.registerLazySingleton(() => CreateComment(locator()));
  locator.registerLazySingleton(() => CreatePost(locator()));
  locator.registerLazySingleton(() => GetPostsByUser(locator()));
  locator.registerLazySingleton(() => DeletePost(locator()));
  locator.registerLazySingleton(() => DeleteComment(locator()));

  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<DetectionRepository>(
    () => DetectionRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<CommunityRepository>(
    () => CommunityRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: locator(), storage: locator()));
  locator.registerLazySingleton<DetectionRemoteDataSource>(() =>
      DetectionRemoteDataSourceImpl(client: locator(), storage: locator()));
  locator.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(secureStorage: locator()));
  locator.registerLazySingleton<CommunityRemoteDataSource>(() =>
      CommunityRemoteDataSourceImpl(client: locator(), storage: locator()));

  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => const FlutterSecureStorage());
}
