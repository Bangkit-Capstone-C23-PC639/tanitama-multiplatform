import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tanitama/core/commons/constants.dart';
import 'package:tanitama/features/community/domain/entities/post_entity.dart';
import 'package:tanitama/features/community/presentation/cubit/delete_post_cubit.dart';
import 'package:tanitama/features/community/presentation/cubit/user_posts_cubit.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.post, this.type = 'all'});

  final PostEntity post;
  final String type;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeletePostCubit, DeletePostState>(
      listener: (context, state) {
        if (state is DeletePostLoading) {
          EasyLoading.show(status: 'Mengahapus...');
        } else if (state is DeletePostSuccess) {
          EasyLoading.showSuccess(state.message);
          BlocProvider.of<UserPostsCubit>(context).fetchAllPostsByUser();
        } else if (state is DeletePostError) {
          EasyLoading.showError(state.message);
        }
      },
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, postDetailRoute, arguments: post.id);
        },
        child: Container(
          width: 100,
          padding: const EdgeInsets.only(
            left: largePadding,
            right: largePadding,
            top: largePadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              post.imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: post.imageUrl!,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => const SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: Center(child: Icon(Icons.error)),
                      ),
                    )
                  : SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/placeholder.png',
                        fit: BoxFit.cover,
                      ),
                    ),
              const SizedBox(
                height: basePadding,
              ),
              Text(post.title, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(
                height: basePadding,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${post.totalComments} komentar',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        width: smallPadding,
                      ),
                      Container(
                        height: 10,
                        width: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: smallPadding,
                      ),
                      Text(
                        timeago.format(DateTime.parse(post.createdAt),
                            locale: 'id'),
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                  type == 'user'
                      ? Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  useSafeArea: true,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    surfaceTintColor: Colors.white,
                                    title: Text(
                                      'Hapus post',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    content: Text(
                                      'Anda yakin ingin menghapus?',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
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
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          )),
                                      FilledButton(
                                          onPressed: () {
                                            BlocProvider.of<DeletePostCubit>(
                                                    context)
                                                .removePost(post.id);
                                            Navigator.pop(context);
                                          },
                                          style: FilledButton.styleFrom(
                                            backgroundColor:
                                                Colors.red.shade400,
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
                              icon: const FaIcon(
                                FontAwesomeIcons.trash,
                                size: 18,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const FaIcon(
                                FontAwesomeIcons.solidPenToSquare,
                                size: 18,
                              ),
                            ),
                          ],
                        )
                      : const Padding(
                          padding: EdgeInsets.symmetric(vertical: largePadding),
                          child: SizedBox(),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
