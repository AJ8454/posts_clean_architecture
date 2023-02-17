import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecture/core/widgets/loading_widget.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/posts_bloc/posts_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/pages/post_add_update_page.dart';
import 'package:posts_clean_architecture/features/posts/presentation/widgets/posts_page/message_display_widget.dart';
import 'package:posts_clean_architecture/features/posts/presentation/widgets/posts_page/post_list_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return const LoadingWidget();
          } else if (state is LoadedPostsState) {
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: PostListWidget(posts: state.posts),
            );
          } else if (state is ErrorPostsState) {
            return MessageDisplayWidget(message: state.message);
          } else {
            return const LoadingWidget();
          }
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }

  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const PostAddUpdatePage(isUpdatePost: false),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
