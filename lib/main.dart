import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:track_info/bottomNavigationBar.dart';
import 'package:track_info/database/database_helper.dart';
import 'package:track_info/models/infoDatabaseModel.dart';
import 'package:track_info/models/infoModel.dart';
import 'package:track_info/services/trackingService.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  WidgetsFlutterBinding.ensureInitialized();
  final TrackingService trackingService = TrackingService();
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid = AndroidInitializationSettings('icon1');
  var initSetttings =
      InitializationSettings(android: initializationSettingsAndroid);
  notificationsPlugin.initialize(initSetttings);
  Workmanager.executeTask((task, inputData) async {
    final DatabaseHelper _databaseHelper = new DatabaseHelper();
    await _databaseHelper.init();
    List<DatabaseModel> data = await _databaseHelper.info();
    for (var i = 0; i < data.length; i++) {
      List<InfoModel> info =
          await trackingService.track(data[i].id, data[i].service);
      if (info[0].comment.substring(0, 3).toUpperCase() == 'OUT') {
        var android = AndroidNotificationDetails(
            'id', 'channel ', 'description',
            priority: Priority.high, importance: Importance.max);
        notificationsPlugin.show(
            1,
            'OUT FOR DELIVERY',
            '${data[i].label} - ${data[i].id}',
            NotificationDetails(android: android));
      }
    }
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final DatabaseHelper databaseHelper = new DatabaseHelper();
  await databaseHelper.init();
  Workmanager.initialize(callbackDispatcher, isInDebugMode: false);
  Workmanager.registerPeriodicTask("2", "simplePeriodicTask",
      initialDelay: Duration(seconds: 10), frequency: Duration(hours: 2));

  runApp(
    MaterialApp(
      home: MyBottomNavigationBar(
        databaseHelper: databaseHelper,
      ),
    ),
  );
}
