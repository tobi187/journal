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
    journalData.department = _preferences.getString("departement") ?? "";
    journalData.berichtsHeftNumber = _preferences.getInt("nr") ?? 1;
    journalData.receiveMails = _preferences.getStringList("mails") ?? [];
  }

  void updateJournalData() {
    _preferences.setString("name", journalData.name);
    _preferences.setString("departement", journalData.department);
    _preferences.setInt("nr", journalData.berichtsHeftNumber);
    _preferences.setStringList("mails", journalData.receiveMails);
  }
}
