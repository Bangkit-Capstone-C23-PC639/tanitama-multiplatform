import 'package:flutter/material.dart';
import 'package:tanitama/features/auth/presentation/login_screen.dart';
import 'package:tanitama/features/auth/presentation/register_screen.dart';
import 'package:tanitama/features/community/presentation/community_screen.dart';
import 'package:tanitama/features/community/presentation/create_post_screen.dart';
import 'package:tanitama/features/community/presentation/post_detail_screen.dart';
import 'package:tanitama/features/community/presentation/user_posts_screen.dart';
import 'package:tanitama/features/detection/domain/entities/detection_detail_entity.dart';
import 'package:tanitama/features/detection/presentation/detection_history_screen.dart';
import 'package:tanitama/features/detection/presentation/detection_result_screen.dart';
import 'package:tanitama/features/home/presentation/home_screen.dart';
import 'package:tanitama/core/commons/constants.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case detectionHistoryRoute:
        return MaterialPageRoute(
            builder: (_) => const DetectionHistoryScreen());
      case communityRoute:
        return MaterialPageRoute(builder: (_) => const CommunityScreen());
      case createPostRoute:
        return MaterialPageRoute(builder: (_) => CreatePostScreen());
      case userPostsRoute:
        return MaterialPageRoute(builder: (_) => const UserPostScreen());
      case postDetailRoute:
        return MaterialPageRoute(builder: (_) {
          final argument = settings.arguments as int;
          return PostDetailScreen(
            postId: argument,
          );
        });
      case detectionResultRoute:
        return MaterialPageRoute(builder: (_) {
          final argument = settings.arguments as DetectionDetailEntity;
          return DetectionResultScreen(
            data: argument,
          );
        });
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
