import 'dart:convert';
import 'package:journal/src/services/data_provider.dart';
import 'package:journal/src/services/meta_data_provider.dart';
import 'package:http/http.dart' as http;
import 'package:week_of_year/week_of_year.dart';

class APIProvider {
  static const baseUrl = "https://server/api/v1/send";
  final JournalProvider journal = JournalProvider();
  final MetaDataProvider metaData = MetaDataProvider();

  Future<bool> sendData() async {
    var url = Uri.parse(baseUrl);
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(_createPayload()),
    );

    if (response.statusCode == 200)
      // ignore: curly_braces_in_flow_control_structures
      return true;
    else
      // ignore: curly_braces_in_flow_control_structures
      return false;
  }

  Map<String, dynamic> _createPayload() {
    var date = metaData.journalData.date.isEmpty
        ? DateTime.now().weekOfYear
        : metaData.journalData.date;
    return {
      "todos": journal.journal.todos,
      "weekly_theme": journal.journal.weeklyTheme,
      "school": journal.journal.school,
      "name": metaData.journalData.name,
      "departement": metaData.journalData.department,
      "berichtNummer": metaData.journalData.berichtsHeftNumber,
      "mails": metaData.journalData.receiveMails,
      "date": date
    };
  }
}
