import 'package:flutter/material.dart';
import 'package:track_info/bottomNavigationBar.dart';
import 'package:track_info/database/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final DatabaseHelper databaseHelper = new DatabaseHelper();
  await databaseHelper.init();

  runApp(
    MaterialApp(
      home: MyBottomNavigationBar(databaseHelper: databaseHelper,),
    ),
  );
}
