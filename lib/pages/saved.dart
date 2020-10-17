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
      print(databaseModel);
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
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        itemCount: databaseModel.length,
        itemBuilder: (_, index) {
          return Card(
            color: Colors.white,
            elevation: 10,
            shadowColor: Colors.grey[400],
            child: ListTile(
              contentPadding:
                  EdgeInsets.only(left: 7, top: 10, bottom: 10, right: 7),
              title: Text(
                '${databaseModel[index].label}  ${databaseModel[index].id}',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800]),
              ),
              subtitle: Column(
                children: [
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Status',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[600])),
                      Text(databaseModel[index].status,
                          style: TextStyle(
                              fontSize: 18,
                              
                              color: Colors.green[600]))
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Date',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[600])),
                      Text(databaseModel[index].date,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.green[600]))
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Time',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[600])),
                      Text(databaseModel[index].time,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.green[600]))
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Location',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[600])),
                      Text(databaseModel[index].lastPlace,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.green[600]))
                    ],
                  ),
                ],
              ),
              onLongPress: () async {
                final ConfirmAction action = await _asyncConfirmDialog(context);

                setState(() {
                  if (action == ConfirmAction.Accept)
                    widget.databaseHelper.removeInfo(databaseModel[index].id);
                  else
                    return;
                });
              },
              // trailing: IconButton(
              //   onPressed: () async {
              //     final ConfirmAction action =
              //         await _asyncConfirmDialog(context);
              //     print(action);
              //     if (action == ConfirmAction.Accept)
              //       widget.databaseHelper.removeInfo(databaseModel[index].id);
              //     else
              //       return;
              //   },
              //   icon: Icon(Icons.delete),
              //   color: Colors.red[300],
              // ),
            ),
          );
        },
      ),
    );
  }
}

enum ConfirmAction { Cancel, Accept }
Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
  return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete This Shipment?'),
          content: const Text(
              'This will delete the Shipment details from your device.'),
          actions: <Widget>[
            FlatButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.Cancel);
              },
            ),
            FlatButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.Accept);
              },
            )
          ],
        );
      });
}
