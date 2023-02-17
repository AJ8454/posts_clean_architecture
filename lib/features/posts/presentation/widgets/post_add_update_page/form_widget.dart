import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecture/features/posts/domain/entites/post.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/add_delete_update_post_bloc/add_delete_update_post_bloc.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;
  const FormWidget({super.key, required this.isUpdatePost, this.post});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  void validateFormThenUpdateOrAddPost() {
    final isvalid = _formKey.currentState!.validate();
    if (isvalid) {
      final post = Post(
        id: widget.isUpdatePost ? widget.post!.id : 0,
        title: _titleController.text,
        body: _bodyController.text,
      );
      if (widget.isUpdatePost) {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(UpdatePostEvent(post: post));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextFormField(
              controller: _titleController,
              validator: (value) =>
                  value!.isEmpty ? "Title can't be empty" : null,
              decoration: const InputDecoration(hintText: "Title"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextFormField(
              controller: _bodyController,
              validator: (value) =>
                  value!.isEmpty ? "Body can't be empty" : null,
              decoration: const InputDecoration(hintText: "Body"),
              maxLines: 6,
              minLines: 6,
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: widget.isUpdatePost
                ? const Icon(Icons.edit)
                : const Icon(Icons.add),
            label: Text(widget.isUpdatePost ? "Update" : "Add"),
          )
        ],
      ),
    );
  }
}
