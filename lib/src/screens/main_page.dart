import 'package:flutter/material.dart';
import 'package:journal/src/services/data_provider.dart';
import 'package:journal/src/widgets/text_field.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  static const routeName = "/";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController berichtController = TextEditingController();
  final TextEditingController aufgabenController = TextEditingController();
  final TextEditingController schulController = TextEditingController();

  final store = JournalProvider();

  @override
  void initState() {
    super.initState();
    berichtController.text = store.journal.todos;
    aufgabenController.text = store.journal.weeklyTheme;
    schulController.text = store.journal.school;
  }

  @override
  void dispose() {
    berichtController.dispose();
    aufgabenController.dispose();
    schulController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Berichtsheft'),
        actions: [
          IconButton(
              onPressed: () => store.updateJournal(),
              icon: const Icon(Icons.delete)),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              //Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Betriebsaufgaben",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: CustomTextField(controller: aufgabenController),
          ),
          const Text(
            "Betriebsbericht",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: CustomTextField(controller: berichtController),
          ),
          const Text(
            "Schule",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: CustomTextField(controller: schulController),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {},
                child: const Text("Send Mail"),
              ),
              ElevatedButton(
                onPressed: () async {},
                child: const Text("Save"),
              )
            ],
          )
        ],
      ),
    );
  }
}
