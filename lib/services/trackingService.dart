// Getting Data from the server
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:track_info/models/infoModel.dart';

class TrackingService {
  Future<List<InfoModel>> track(String trackingId, String service) async {
    final url =
        "https://trackinfoapi.onrender.com/track?id=$trackingId&service=$service";
    dynamic res = await http.get(url);
    try {
      return (jsonDecode(res.body) as List).map((e) => InfoModel.fromjson(e)).toList();
      
    } catch (err) {
      return [];
    }
  }
}
