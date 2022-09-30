import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:journal/src/models/journal_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MetaDataProvider {
  static final MetaDataProvider _instance = MetaDataProvider._internal();
  factory MetaDataProvider() => _instance;

  MetaDataProvider._internal();

  Future<void> getInstance() async {
    _preferences = await SharedPreferences.getInstance();
    loadJournalData();
    FlutterNativeSplash.remove();
  }

  late SharedPreferences _preferences;
  final JournalData journalData = JournalData(receiveMails: []);

  void loadJournalData() {
    journalData.name = _preferences.getString("name") ?? "";
    journalData.department = _preferences.getString("department") ?? "";
    journalData.berichtsHeftNumber = _preferences.getInt("nr") ?? 1;
    journalData.receiveMails = _preferences.getStringList("mails") ?? [];
    journalData.date = _preferences.getString("date") ?? "";
    journalData.schoolTemplate = _preferences.getString("schoolT") ?? "";
    journalData.point = _preferences.getString("point") ?? "";
  }

  void updateJournalData() {
    _preferences.setString("name", journalData.name);
    _preferences.setString("department", journalData.department);
    _preferences.setInt("nr", journalData.berichtsHeftNumber);
    _preferences.setStringList("mails", journalData.receiveMails);
    _preferences.setString("date", journalData.date);
    _preferences.setString("schoolT", journalData.schoolTemplate);
    _preferences.setString("point", journalData.point);
  }

  String getSchoolTemplate() {
    var tempData = _preferences.getString("schoolT") ?? "";

    if (tempData.isEmpty) return "";

    return tempData
        .split(",")
        .map((e) => e.trim())
        .map((e) => "$e: ")
        .join("\n");
  }

  Future postSaveWork() async {
    journalData.berichtsHeftNumber += 1;
    await _preferences.setInt("nr", journalData.berichtsHeftNumber);
  }

  Future updatePartially(JournalData data) async {
    if (journalData.name != data.name) {
      await _preferences.setString("name", data.name);
      journalData.name = data.name;
    }
    if (journalData.department != data.department) {
      await _preferences.setString("department", data.department);
      journalData.department = data.department;
    }
    if (journalData.berichtsHeftNumber != data.berichtsHeftNumber) {
      await _preferences.setInt("nr", data.berichtsHeftNumber);
      journalData.berichtsHeftNumber = data.berichtsHeftNumber;
    }
    if (journalData.receiveMails != data.receiveMails) {
      await _preferences.setStringList("mails", data.receiveMails);
      journalData.receiveMails = data.receiveMails;
    }
    if (journalData.date != data.date) {
      await _preferences.setString("date", data.date);
      journalData.date = data.date;
    }
    if (journalData.schoolTemplate != data.schoolTemplate) {
      await _preferences.setString("schoolT", data.schoolTemplate);
      journalData.schoolTemplate = data.schoolTemplate;
    }
    if (journalData.point != data.point) {
      _preferences.setString("point", data.point);
      journalData.point = data.point;
    }
  }
}
