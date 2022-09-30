import 'dart:convert';
import 'package:journal/src/services/data_provider.dart';
import 'package:journal/src/services/meta_data_provider.dart';
import 'package:http/http.dart' as http;
import 'package:week_of_year/week_of_year.dart';

const apiSecret = "@sWMi#N&z#g@X4xmobQbfYy&3**6y3sH7Q&!VFajy";

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
        "ACCESS-KEY-CONTENT": apiSecret
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
    var date = metaData.journalData.date.isEmpty
        ? DateTime.now().weekOfYear.toString()
        : metaData.journalData.date;

    return {
      "todos": journal.journal.todos.trim(),
      "weekly_theme": journal.journal.weeklyTheme.trim(),
      "school": journal.journal.school.trim(),
      "name": metaData.journalData.name.trim(),
      "department": metaData.journalData.department.trim(),
      "berichtNummer": metaData.journalData.berichtsHeftNumber,
      "mails": metaData.journalData.receiveMails,
      "date": date.trim(),
      "point": metaData.journalData.point.trim()
    };
  }
}
