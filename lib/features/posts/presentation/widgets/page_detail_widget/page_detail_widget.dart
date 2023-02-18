import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecture/core/utils/snackbar_message.dart';
import 'package:posts_clean_architecture/core/widgets/loading_widget.dart';
import 'package:posts_clean_architecture/features/posts/domain/entites/post.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/add_delete_update_post_bloc/add_delete_update_post_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/pages/post_add_update_page.dart';
import 'package:posts_clean_architecture/features/posts/presentation/pages/posts_page.dart';
import 'package:posts_clean_architecture/features/posts/presentation/widgets/page_detail_widget/delete_dialog_widget.dart';

class PageDetailWidget extends StatelessWidget {
  final Post post;
  const PageDetailWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              post.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 50),
            Text(
              post.body,
              style: const TextStyle(fontSize: 16),
            ),
            const Divider(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            PostAddUpdatePage(isUpdatePost: true, post: post),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text(
                    "Edit",
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => deleteDialog(context),
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete"),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void deleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
          listener: (context, state) {
            if (state is MessageAddDeleteUpdatePostState) {
              SnackBarMessage().showSuccessSnackBar(
                  message: state.message, context: context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const PostsPage()),
                  (route) => false);
            } else if (state is ErrorAddDeleteUpdatePostState) {
              Navigator.pop(context);
              SnackBarMessage()
                  .showErrorSnackBar(message: state.message, context: context);
            }
          },
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdatePostState) {
              return const AlertDialog(title: LoadingWidget());
            }
            return DeleteDialogWidget(postId: post.id!);
          },
        );
      },
    );
  }
}
