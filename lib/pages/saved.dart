import 'package:flutter/material.dart';
import 'package:track_info/database/database_helper.dart';
import 'package:track_info/models/infoDatabaseModel.dart';

class Saved extends StatefulWidget {
  final DatabaseHelper databaseHelper;
  Saved({this.databaseHelper});

  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  List<DatabaseModel> databaseModel;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    List<DatabaseModel> temp = await widget.databaseHelper.info();
    setState(() {
      databaseModel = temp;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shipments'),
        backgroundColor: Colors.amber[600],
      ),
      body: databaseModel == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SavedView(),
    );
  }

  Widget SavedView() {
    return Center(
      child: ListView.builder(
        itemCount: databaseModel.length,
        itemBuilder: (_, index) {
          return ListTile(
            title: Text(databaseModel[index].id),
            subtitle: Column(
              children: [
                Text(databaseModel[index].label),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Status'),
                    Text(databaseModel[index].lastPlace)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Date'), Text(databaseModel[index].date)],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Time'), Text(databaseModel[index].time)],
                )
              ],
            ),
            trailing: IconButton(
              onPressed: () async {
                widget.databaseHelper.removeInfo(databaseModel[index].id);
              },
              icon: Icon(Icons.delete),
            ),
          );
        },
      ),
    );
  }
}
