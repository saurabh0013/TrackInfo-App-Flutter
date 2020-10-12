class InfoModel {
  String date;
  String time;
  String status;
  String location;
  String comment;
  InfoModel.fromjson(data) {
    date = data["date"];
    time = data["time"];
    status = data["status"];
    location = data["place"];
    comment = data["comment"];
  }
}
