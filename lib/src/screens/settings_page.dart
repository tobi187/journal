import 'package:flutter/material.dart';
import 'package:journal/src/services/meta_data_provider.dart';
import 'package:journal/src/widgets/settings_item.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final metaData = MetaDataProvider();
  final kwController = TextEditingController();
  final bhnrController = TextEditingController();
  final mailController = TextEditingController();
  final nameController = TextEditingController();
  final departementController = TextEditingController();
  final schoolController = TextEditingController();

  void update() {
    kwController.text = metaData.journalData.date;
    bhnrController.text = metaData.journalData.berichtsHeftNumber.toString();
    nameController.text = metaData.journalData.name;
    departementController.text = metaData.journalData.department;
    schoolController.text = "";
    mailController.text = metaData.journalData.receiveMails.join(", ");
  }

  @override
  void initState() {
    super.initState();
    update();
  }

  @override
  void dispose() {
    super.dispose();
    kwController.dispose();
    bhnrController.dispose();
    nameController.dispose();
    departementController.dispose();
    schoolController.dispose();
    mailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          DropdownButton<ThemeMode>(
            // Read the selected themeMode from the controller
            //value: controller.themeMode,
            // Call the updateThemeMode method any time the user selects a theme.
            //onChanged: controller.updateThemeMode,
            onChanged: null,
            items: const [
              DropdownMenuItem(
                value: ThemeMode.system,
                child: Text('System Theme'),
              ),
              DropdownMenuItem(
                value: ThemeMode.light,
                child: Text('Light Theme'),
              ),
              DropdownMenuItem(
                value: ThemeMode.dark,
                child: Text('Dark Theme'),
              ),
            ],
          ),
          SettingCard(
            labelText: "Emails",
            widget: TextField(
              controller: mailController,
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          SettingsNumberCard(
            labelText: "Kalenderwoche",
            controller: kwController,
          ),
          SettingCard(
            labelText: "Name",
            widget: TextField(
              controller: nameController,
            ),
          ),
          SettingCard(
            labelText: "Abteilung",
            widget: TextField(
              controller: departementController,
            ),
          ),
          SettingsNumberCard(
            labelText: "Betriebsheftnummer",
            controller: bhnrController,
          ),
          SettingCard(
            labelText: "SchulTemplate",
            widget: TextField(
              controller: schoolController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: ElevatedButton(
              onPressed: () {
                metaData.journalData.name = nameController.text;
                metaData.journalData.department = departementController.text;
                metaData.journalData.date = kwController.text;
                metaData.journalData.berichtsHeftNumber =
                    int.parse(bhnrController.text);
                metaData.journalData.receiveMails = mailController.text
                    .split(",")
                    .map((e) => e.trim())
                    .toList();
                metaData.journalData.date = kwController.text;

                metaData.updateJournalData();
              },
              child: const Text("Save"),
            ),
          )
        ],
      ),
    );
  }
}
