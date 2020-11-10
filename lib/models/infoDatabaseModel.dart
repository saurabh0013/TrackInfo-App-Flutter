class DatabaseModel {
  final String id;
  final String label;
  final String status;
  final String lastPlace;
  final String date;
  final String time;
  final String service;
  DatabaseModel(
      {this.id, this.label, this.status, this.lastPlace, this.date, this.time, this.service});
  Map<String, dynamic> toMap() {
    return ({
      'id': id,
      'label': label,
      'status': status,
      'lastPlace': lastPlace,
      'date': date,
      'time': time,
      'service' : service
    });
  }
}
