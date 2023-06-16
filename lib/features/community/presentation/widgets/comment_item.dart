import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:tanitama/core/commons/constants.dart';
import 'package:tanitama/features/community/domain/entities/comment_entity.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    super.key,
    required this.comment,
  });

  final CommentEntity comment;

  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
      key: ObjectKey(comment.id.toString()),
      // trailingActions: <SwipeAction>[
      //   SwipeAction(
      //       title: "Hapus",
      //       onTap: (CompletionHandler handler) async {
      //         /// await handler(true) : will delete this row
      //         /// And after delete animation,setState will called to
      //         /// sync your data source with your UI

      //         await handler(true);
      //         //  list.removeAt(index);
      //         //  setState(() {});
      //       },
      //       color: Colors.red),
      // ],
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
            Text(comment.content, style: Theme.of(context).textTheme.bodyLarge),
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
    );
  }
}
