import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecture/core/utils/snackbar_message.dart';
import 'package:posts_clean_architecture/core/widgets/loading_widget.dart';
import 'package:posts_clean_architecture/features/posts/domain/entites/post.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/add_delete_update_post_bloc/add_delete_update_post_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/pages/posts_page.dart';
import 'package:posts_clean_architecture/features/posts/presentation/widgets/post_add_update_page/form_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;
  const PostAddUpdatePage({super.key, this.post, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: Text(
        isUpdatePost ? "Edit Post" : "Add Post",
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
        listener: (context, state) {
          if (state is MessageAddDeleteUpdatePostState) {
            SnackBarMessage()
                .showSuccessSnackBar(message: state.message, context: context);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const PostsPage()),
                (route) => false);
          } else if (state is ErrorAddDeleteUpdatePostState) {
            SnackBarMessage()
                .showErrorSnackBar(message: state.message, context: context);
          }
        },
        builder: (context, state) {
          if (state is LoadingAddDeleteUpdatePostState) {
            return const LoadingWidget();
          }
          return FormWidget(
              isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
        },
      ),
    );
  }
}
