class JournalData {
  String name;
  List<String> receiveMails;
  String department;
  String date;
  int berichtsHeftNumber;

  JournalData(
      {required this.receiveMails,
      this.name = "",
      this.department = "",
      this.berichtsHeftNumber = 1,
      this.date = "01.01.2000"});
}
