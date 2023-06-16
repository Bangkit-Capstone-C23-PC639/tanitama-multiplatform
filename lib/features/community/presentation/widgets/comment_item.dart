import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:tanitama/features/community/domain/usecases/delete_comment.dart';
import 'package:tanitama/features/community/presentation/cubit/delete_comment_cubit.dart';
import 'package:tanitama/features/community/presentation/cubit/post_detail_cubit.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:tanitama/core/commons/constants.dart';
import 'package:tanitama/features/community/domain/entities/comment_entity.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    super.key,
    required this.comment,
    required this.userId,
  });

  final CommentEntity comment;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteCommentCubit, DeleteCommentState>(
      listener: (context, state) {
        if (state is DeleteCommentLoading) {
          EasyLoading.show(status: 'Mengahapus...');
        } else if (state is DeleteCommentSuccess) {
          BlocProvider.of<PostDetailCubit>(context)
              .fetchPostById(comment.postId);
          EasyLoading.showSuccess(state.message);
        } else if (state is DeleteCommentError) {
          EasyLoading.showError(state.message);
        }
      },
      child: SwipeActionCell(
        key: ObjectKey(comment.id.toString()),
        trailingActions: userId == comment.userId.toString()
            ? [
                SwipeAction(
                    title: "Hapus",
                    onTap: (CompletionHandler handler) {
                      showDialog(
                        context: context,
                        useSafeArea: true,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.white,
                          surfaceTintColor: Colors.white,
                          title: Text(
                            'Hapus post',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          content: Text(
                            'Anda yakin ingin menghapus?',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          actions: [
                            FilledButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: FilledButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    elevation: 1),
                                child: Text(
                                  'Batal',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )),
                            FilledButton(
                                onPressed: () {
                                  BlocProvider.of<DeleteCommentCubit>(context)
                                      .removeComment(comment.id);
                                  Navigator.pop(context);
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.red.shade400,
                                ),
                                child: Text(
                                  'Hapus',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                )),
                          ],
                        ),
                      );
                    },
                    color: Colors.red),
              ]
            : [],
        child: Container(
          padding: const EdgeInsets.all(largePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(comment.commentator.photo),
                    radius: 15,
                  ),
                  Text(
                    comment.commentator.name,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  )
                ],
              ),
              const SizedBox(
                height: basePadding,
              ),
              Text(comment.content,
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(
                height: basePadding,
              ),
              Text(
                timeago.format(DateTime.parse(comment.createdAt), locale: 'id'),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: basePadding,
              ),
              Container(
                height: 1,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
