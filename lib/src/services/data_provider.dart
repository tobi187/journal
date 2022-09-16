import 'package:journal/src/models/journal.dart';
import 'package:journal/src/models/journal_data.dart';
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
  final JournalData journalData = JournalData(receiveMails: []);

  void loadJournal() {
    journal.todos = _preferences.getString("todo") ?? "";
    journal.weeklyTheme = _preferences.getString("weeklyTheme") ?? "";
    journal.school = _preferences.getString("school") ?? "";
  }

  void updateJournal() {
    _preferences.setString("todo", journal.todos);
    _preferences.setString("weeklyTheme", journal.weeklyTheme);
    _preferences.setString("school", journal.school);
  }

  void clearJournal() {
    _preferences.setString("todo", "");
    _preferences.setString("weeklyTheme", "");
    _preferences.setString("school", "");
  }
}
