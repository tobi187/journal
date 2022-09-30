import 'package:journal/src/models/journal.dart';
import 'package:journal/src/services/meta_data_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JournalProvider {
  static final JournalProvider _instance = JournalProvider._internal();
  factory JournalProvider() => _instance;

  JournalProvider._internal();

  Future<void> getInstance() async {
    _preferences = await SharedPreferences.getInstance();
    loadJournal();
  }

  late SharedPreferences _preferences;
  final Journal journal = Journal();

  void loadJournal() {
    journal.todos = _preferences.getString("todo") ?? "";
    journal.weeklyTheme = _preferences.getString("weeklyTheme") ?? "";
    journal.school = _preferences.getString("school") ?? "";
  }

  Future updateJournal() async {
    await _preferences.setString("todo", journal.todos);
    await _preferences.setString("weeklyTheme", journal.weeklyTheme);
    await _preferences.setString("school", journal.school);
  }

  Future clearJournal() async {
    var schools = MetaDataProvider().getSchoolTemplate();
    await _preferences.setString("todo", "");
    await _preferences.setString("weeklyTheme", "");
    await _preferences.setString("school", schools);
    journal.todos = "";
    journal.weeklyTheme = "";
    journal.school = schools;
  }
}
