import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:track_info/animations/FadeAnimation.dart';
import 'package:track_info/services/trackingService.dart';
import 'package:track_info/database/database_helper.dart';
import 'package:track_info/models/infoDatabaseModel.dart';
import 'package:track_info/models/infoModel.dart';
import 'details.dart';

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

  ProgressDialog progressDialog;
  final _trackingService = TrackingService();
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(
        message: ' Getting latest details...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        messageTextStyle: TextStyle(
            color: Colors.orange[600],
            fontSize: 19.0,
            fontWeight: FontWeight.w400));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Shipments',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange[400],
      ),
      body: databaseModel == null
          ? Center(
              child: Container(
                  constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/background.jpg"),
                          fit: BoxFit.cover)),
                  child: CircularProgressIndicator()),
            )
          : savedView(),
    );
  }

  Widget savedView() {
    return Container(
      child: FadeAnimation(
        0.2,
        Center(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            itemCount: databaseModel.length,
            itemBuilder: (_, index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                color: Colors.white,
                elevation: 10,
                shadowColor: Colors.grey[400],
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tracking Id : ',
                        style: TextStyle(
                            fontSize: 23.5,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue[800]),
                      ),
                      Text(
                        databaseModel[index].id,
                        style: TextStyle(
                            fontSize: 23.5,
                            fontWeight: FontWeight.w400,
                            color: Colors.green),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    children: [
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Label : ',
                              style: TextStyle(
                                  fontSize: 23.5,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blue[800])),
                          Text(databaseModel[index].label,
                              style: TextStyle(
                                  fontSize: 23.5,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.green))
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Courier : ',
                              style: TextStyle(
                                  fontSize: 23.5,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blue[800])),
                          Text(databaseModel[index].service,
                              style: TextStyle(
                                  fontSize: 23.5,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.green))
                        ],
                      )
                    ],
                  ),
                  onTap: () async {
                    progressDialog.show();
                    List<InfoModel> data = await _trackingService.track(
                        databaseModel[index].id, databaseModel[index].service);
                    await progressDialog.hide();
                    await progressDialog.hide();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Details(
                            data,
                            databaseModel[index].label,
                            databaseModel[index].id,
                            databaseModel[index].service)));
                  },
                  onLongPress: () async {
                    final ConfirmAction action =
                        await _asyncConfirmDialog(context);

                    if (action == ConfirmAction.Accept) {
                      widget.databaseHelper.removeInfo(databaseModel[index].id);
                      setState(() {
                        loadData();
                      });
                    } else
                      return;
                  },
                ),
              );
            },
          ),
        ),
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
