import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: TextField(
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 30,
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(8), border: InputBorder.none),
          style: const TextStyle(fontSize: 17),
          controller: controller,
        ),
      ),
    );
  }
}
