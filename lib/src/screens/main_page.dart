import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:journal/src/screens/settings_page.dart';
import 'package:journal/src/services/api_provider.dart';
import 'package:journal/src/services/data_provider.dart';
import 'package:journal/src/widgets/text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final berichtController = TextEditingController();
  final aufgabenController = TextEditingController();
  final schulController = TextEditingController();

  final store = JournalProvider();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    aufgabenController.text = store.journal.todos;
    berichtController.text = store.journal.weeklyTheme;
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
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                await store.clearJournal();

                aufgabenController.text = store.journal.todos;
                berichtController.text = store.journal.weeklyTheme;
                schulController.text = store.journal.school;
                setState(() {
                  _isLoading = false;
                });
              },
              icon: const Icon(Icons.delete)),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, Settings.routeName);
            },
          ),
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: Column(
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
                  onPressed: () async {
                    if (await confirm(context)) {
                      setState(() {
                        _isLoading = true;
                      });
                      var res = await APIProvider().sendData();
                      if (res) {
                        await store.clearJournal();

                        aufgabenController.text = store.journal.todos;
                        berichtController.text = store.journal.weeklyTheme;
                        schulController.text = store.journal.school;
                        setState(() {
                          _isLoading = false;
                        });
                        Fluttertoast.showToast(msg: "Success");
                      } else {
                        setState(() {
                          _isLoading = false;
                        });
                        Fluttertoast.showToast(
                          msg: "Sorry something went wrong",
                        );
                      }
                    }
                  },
                  child: const Text("Send Mail"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    store.journal.todos = aufgabenController.text;
                    store.journal.weeklyTheme = berichtController.text;
                    store.journal.school = schulController.text;

                    await store.updateJournal();
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
