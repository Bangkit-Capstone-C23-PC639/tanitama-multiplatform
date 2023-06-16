import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tanitama/core/commons/constants.dart';
import 'package:tanitama/core/presentation/widgets/empty_widget.dart';
import 'package:tanitama/features/community/presentation/cubit/community_cubit.dart';
import 'package:tanitama/features/community/presentation/widgets/post_item.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    BlocProvider.of<CommunityCubit>(context).fetchAllPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Komunitas',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, userPostsRoute);
            },
            icon: const FaIcon(
              FontAwesomeIcons.user,
              size: 20,
            ),
          )
        ],
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, createPostRoute);
        },
        backgroundColor: primaryColor,
        child: const FaIcon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
      ),
      body: BlocBuilder<CommunityCubit, CommunityState>(
        builder: (context, state) {
          if (state is PostsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PostsSuccess) {
            return RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () async {
                BlocProvider.of<CommunityCubit>(context).fetchAllPosts();
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
                          PostItem(post: state.posts[index]),
                    )
                  : const EmptyWidget(message: 'Tidak ada post'),
            );
          } else if (state is PostsError) {
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
