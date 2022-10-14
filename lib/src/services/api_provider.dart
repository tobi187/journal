import 'dart:convert';
import 'package:journal/src/services/data_provider.dart';
import 'package:journal/src/services/meta_data_provider.dart';
import 'package:http/http.dart' as http;
import 'package:week_of_year/week_of_year.dart';
import 'package:journal/src/globals.dart' as globals;

// library journal.globals;

class APIProvider {
  static const baseUrl =
      "https://sharedshopping.eu.pythonanywhere.com/api/v1/word";
  final JournalProvider journal = JournalProvider();
  final MetaDataProvider metaData = MetaDataProvider();

  Future<bool> sendData() async {
    var url = Uri.parse(baseUrl);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "ACCESS-KEY-CONTENT": globals.API_KEY
      },
      body: jsonEncode(_createPayload()),
    );

    if (response.statusCode == 200) {
      metaData.postSaveWork();
      return true;
    } else {
      return false;
    }
  }

  Map<String, dynamic> _createPayload() {
    return {
      "todos": journal.journal.todos.trim(),
      "weekly_theme": journal.journal.weeklyTheme.trim(),
      "school": journal.journal.school.trim(),
      "name": metaData.journalData.name.trim(),
      "department": metaData.journalData.department.trim(),
      "berichtNummer": metaData.journalData.berichtsHeftNumber,
      "mails": metaData.journalData.receiveMails,
      "date": getDate(metaData.journalData.date).trim(),
      "point": metaData.journalData.point.trim()
    };
  }

  String getDate(String userDate) {
    int calendarWeek = DateTime.now().weekOfYear;
    if (userDate.isEmpty) return calendarWeek.toString();
    if (userDate.startsWith("-")) {
      var diff = int.tryParse(userDate) ?? 0;
      return (calendarWeek + diff).toString();
    }
    return userDate;
  }
}
