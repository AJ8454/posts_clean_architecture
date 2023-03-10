import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final bool multiLines;
  final TextEditingController controller;
  final String name;
  const TextFormFieldWidget(
      {super.key,
      required this.controller,
      required this.multiLines,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        controller: controller,
        validator: (value) => value!.isEmpty ? "$name can't be empty" : null,
        decoration: InputDecoration(hintText: name),
        maxLines: multiLines ? 6 : 1,
        minLines: multiLines ? 6 : 1,
      ),
    );
  }
}
