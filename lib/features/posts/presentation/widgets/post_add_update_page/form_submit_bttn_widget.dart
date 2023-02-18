import 'package:flutter/material.dart';

class FormSubmitBttnWidget extends StatelessWidget {
  const FormSubmitBttnWidget(
      {super.key, required this.isUpdatePost, required this.onPressed});

  final void Function() onPressed;
  final bool isUpdatePost;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: isUpdatePost ? const Icon(Icons.edit) : const Icon(Icons.add),
      label: Text(isUpdatePost ? "Update" : "Add"),
    );
  }
}
