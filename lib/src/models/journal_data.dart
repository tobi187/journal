class JournalData {
  String name;
  List<String> receiveMails;
  String department;
  String date;
  int berichtsHeftNumber;
  String schoolTemplate;
  String point;

  JournalData(
      {required this.receiveMails,
      this.name = "",
      this.department = "",
      this.berichtsHeftNumber = 1,
      this.date = "",
      this.schoolTemplate = "",
      this.point = ""});
}
