import 'package:tanitama/features/community/data/models/post_model.dart';

class PostsResponse {
  final List<PostModel> posts;

  PostsResponse({required this.posts});

  factory PostsResponse.fromJson(Map<String, dynamic> json) => PostsResponse(
        posts: List<PostModel>.from(
            json["data"].map((x) => PostModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(posts.map((x) => x.toJson())),
      };
}
