import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tanitama/core/commons/constants.dart';
import 'package:tanitama/core/presentation/widgets/cutom_text_field.dart';
import 'package:tanitama/features/community/presentation/cubit/create_comment_cubit.dart';
import 'package:tanitama/features/community/presentation/cubit/post_detail_cubit.dart';
import 'package:tanitama/features/community/presentation/widgets/comment_item.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({super.key, required this.postId});

  final int postId;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final TextEditingController _contentEditingController =
      TextEditingController();
  final ValueNotifier<bool> _isTextEmpty = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostDetailCubit>(context).fetchPostById(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: 80,
          width: double.infinity,
          padding: const EdgeInsets.only(
            bottom: basePadding,
            left: basePadding,
            right: smallPadding,
            top: basePadding,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade900,
                blurRadius: 5.0,
                spreadRadius: 5,
                offset: const Offset(
                  0,
                  10,
                ),
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _contentEditingController,
                  fillColor: const Color(0XFFF0F2F5),
                  textInputAction: TextInputAction.done,
                  hint: 'Berikan komentar...',
                  onChanged: (value) {
                    _isTextEmpty.value = value.isEmpty;
                  },
                ),
              ),
              BlocListener<CreateCommentCubit, CreateCommentState>(
                listener: (commentState, state) {
                  if (state is CreateCommentLoading) {
                    EasyLoading.show(status: 'Menambahkan komentar...');
                  } else if (state is CreateCommentSuccess) {
                    _contentEditingController.text = '';
                    EasyLoading.showSuccess(state.message);
                    BlocProvider.of<PostDetailCubit>(context)
                        .fetchPostById(widget.postId);
                  }
                },
                child: ValueListenableBuilder<bool>(
                  valueListenable: _isTextEmpty,
                  builder: (context, isTextEmpty, _) {
                    return isTextEmpty
                        ? const SizedBox()
                        : IconButton(
                            onPressed: () {
                              BlocProvider.of<CreateCommentCubit>(context)
                                  .postComment(widget.postId,
                                      _contentEditingController.text);
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.solidPaperPlane,
                              color: primaryColor,
                            ),
                          );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      body: BlocBuilder<PostDetailCubit, PostDetailState>(
        builder: (context, state) {
          if (state is PostDetailSuccess) {
            final post = state.post;
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(largePadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 10,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(post.author.photo!),
                              radius: 15,
                            ),
                            Text(
                              post.author.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: basePadding,
                        ),
                        Text(
                          post.title,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(
                          height: basePadding,
                        ),
                        Text(post.content!,
                            style: Theme.of(context).textTheme.bodyLarge),
                        const SizedBox(
                          height: basePadding,
                        ),
                        Text(
                          timeago.format(DateTime.parse(post.createdAt),
                              locale: 'id'),
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
                  post.comments!.isNotEmpty
                      ? ListView.builder(
                          padding: const EdgeInsets.only(left: largePadding),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: post.comments!.length,
                          itemBuilder: (context, index) => CommentItem(
                            comment: post.comments![index],
                            userId: state.userId,
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            );
          } else if (state is PostDetailError) {
            return Center(
              child: Text(
                state.message,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
