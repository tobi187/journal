import 'package:flutter/material.dart';

class SettingCard extends StatelessWidget {
  const SettingCard({super.key, required this.labelText, required this.widget});
  final String labelText;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              " $labelText",
              style: const TextStyle(fontSize: 20),
            ),
            widget,
          ],
        ),
      ),
    );
  }
}

class SettingsNumberCard extends StatelessWidget {
  const SettingsNumberCard(
      {super.key, required this.labelText, this.controller});
  final String labelText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              " $labelText",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 30),
            SizedBox(
              width: 100,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                maxLength: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
