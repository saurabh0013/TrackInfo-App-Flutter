class DatabaseModel {
  final String id;
  final String label;
  final String status;
  final String lastPlace;
  final String date;
  final String time;
  DatabaseModel(
      {this.id, this.label, this.status, this.lastPlace, this.date, this.time});
  Map<String, dynamic> toMap() {
    return ({
      'id': id,
      'label': label,
      'status': status,
      'lastPlace': lastPlace,
      'date': date,
      'time': time
    });
  }
}
