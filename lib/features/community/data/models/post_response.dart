import 'package:tanitama/features/community/data/models/post_model.dart';

class PostResponse {
  final PostModel post;

  PostResponse({required this.post});

  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
        post: PostModel.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        "data": post.toJson(),
      };
}
