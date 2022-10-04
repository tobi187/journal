import 'package:flutter/material.dart';
import 'package:journal/src/models/journal_data.dart';
import 'package:journal/src/services/meta_data_provider.dart';
import 'package:journal/src/settings/settings_controller.dart';
import 'package:journal/src/widgets/settings_item.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Settings extends StatefulWidget {
  const Settings({super.key, required this.settingsController});
  final SettingsController settingsController;

  static const routeName = "/settings";

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isLoading = false;

  final metaData = MetaDataProvider();
  final kwController = TextEditingController();
  final bhnrController = TextEditingController();
  final mailController = TextEditingController();
  final nameController = TextEditingController();
  final departmentController = TextEditingController();
  final schoolController = TextEditingController();
  final pointController = TextEditingController();

  void update() {
    kwController.text = metaData.journalData.date;
    bhnrController.text = metaData.journalData.berichtsHeftNumber.toString();
    nameController.text = metaData.journalData.name;
    departmentController.text = metaData.journalData.department;
    schoolController.text = "";
    mailController.text = metaData.journalData.receiveMails.join(", ");
    schoolController.text = metaData.journalData.schoolTemplate;
    pointController.text = metaData.journalData.point;
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
    departmentController.dispose();
    schoolController.dispose();
    mailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ModalProgressHUD(
        blur: 1.5,
        inAsyncCall: _isLoading,
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: DropdownButton<ThemeMode>(
                onChanged: widget.settingsController.updateThemeMode,
                value: widget.settingsController.themeMode,
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
                controller: departmentController,
              ),
            ),
            SettingsNumberCard(
              labelText: "Betriebsheftnummer",
              controller: bhnrController,
            ),
            SettingsNumberCard(
              labelText: "Punkte",
              controller: pointController,
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
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  var temp = JournalData(
                      receiveMails: mailController.text
                          .split(",")
                          .map((e) => e.trim())
                          .toList());
                  temp.name = nameController.text;
                  temp.department = departmentController.text;
                  temp.date = kwController.text;
                  temp.schoolTemplate = schoolController.text;
                  temp.date = kwController.text;
                  temp.point = pointController.text;
                  temp.berichtsHeftNumber = int.parse(bhnrController.text);

                  await metaData.updatePartially(temp);

                  setState(() {
                    _isLoading = false;
                  });
                },
                child: const Text("Save"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
