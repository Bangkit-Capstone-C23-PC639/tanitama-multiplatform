import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanitama/core/commons/constants.dart';
import 'package:tanitama/core/presentation/widgets/empty_widget.dart';
import 'package:tanitama/features/community/presentation/cubit/user_posts_cubit.dart';
import 'package:tanitama/features/community/presentation/widgets/post_item.dart';

class UserPostScreen extends StatefulWidget {
  const UserPostScreen({super.key});

  @override
  State<UserPostScreen> createState() => _UserPostScreenState();
}

class _UserPostScreenState extends State<UserPostScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    BlocProvider.of<UserPostsCubit>(context).fetchAllPostsByUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Post Saya',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<UserPostsCubit, UserPostsState>(
        builder: (context, state) {
          if (state is UserPostsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserPostsSuccess) {
            return RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () async {
                BlocProvider.of<UserPostsCubit>(context).fetchAllPostsByUser();
              },
              child: state.posts.isNotEmpty
                  ? ListView.separated(
                      itemCount: state.posts.length,
                      separatorBuilder: (context, index) => Container(
                        height: 1,
                        color: Colors.grey,
                        margin: const EdgeInsets.symmetric(
                            horizontal: largePadding),
                      ),
                      itemBuilder: (context, index) =>
                          PostItem(post: state.posts[index], type: 'user'),
                    )
                  : const EmptyWidget(message: 'Tidak ada post'),
            );
          } else if (state is UserPostsError) {
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
