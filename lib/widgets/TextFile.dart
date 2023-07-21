import 'package:flutter/material.dart';

class TextFileWidget extends StatelessWidget {
  const TextFileWidget({
    super.key,
    required this.hintText,
    required this.maxLine,
    required this.txtController,
  });

  final String hintText;
  final int maxLine;
  final TextEditingController txtController;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16)),
        child: TextField(
          controller: txtController,
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hintText,
          ),
          maxLines: maxLine,
        ));
  }
}
