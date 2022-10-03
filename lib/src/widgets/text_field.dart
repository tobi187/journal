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

class CustomTextFieldWithNLCount extends StatelessWidget {
  const CustomTextFieldWithNLCount({Key? key, required this.controller})
      : super(key: key);

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
          buildCounter: (context,
              {required currentLength, required isFocused, maxLength}) {
            int number = controller.text.split("\n").length;
            return Text(
              '$number/11',
              style: Theme.of(context).textTheme.caption,
            );
          },
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(8), border: InputBorder.none),
          style: const TextStyle(fontSize: 17),
          controller: controller,
        ),
      ),
    );
  }
}

class CustomTextFieldWithWordCount extends StatelessWidget {
  const CustomTextFieldWithWordCount({Key? key, required this.controller})
      : super(key: key);

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
          maxLength: 1000,
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(8), border: InputBorder.none),
          style: const TextStyle(fontSize: 17),
          controller: controller,
        ),
      ),
    );
  }
}
