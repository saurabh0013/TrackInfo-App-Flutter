import 'package:flutter/material.dart';
import 'package:track_info/models/infoModel.dart';

class Details extends StatelessWidget {
  final List<InfoModel> infoModel;
  final String label;
  final String trackingId;
  final String service;
  Details(this.infoModel, this.label, this.trackingId, this.service);

  @override
  Widget build(BuildContext context) {
    String _statusbar = '';

    Color statusbarColor;
    if (infoModel[0].status.substring(0, 9).toUpperCase() == 'DELIVERED' ||
        infoModel[0].status.substring(0, 3).toUpperCase() == 'OUT') {
      statusbarColor = Colors.green;
      _statusbar = infoModel[0].status.toUpperCase();
    } else if (infoModel[0].status.substring(0, 9).toUpperCase() ==
        'RETURNED') {
      statusbarColor = Colors.red;
      _statusbar = infoModel[0].status.toUpperCase();
    } else {
      statusbarColor = Colors.blue;
      _statusbar = 'IN TRANSIT';
    }
    return Scaffold(
        // backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          title: Text(label),
          backgroundColor: Colors.orange[400],
        ),
        body: Column(
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(8, 20, 8, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        color: Colors.red,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                        child: Text(
                          service,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        )),
                    Container(
                        color: Colors.grey[700],
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                        child: Text(
                          trackingId,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                color: statusbarColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Center(
                      child: Text(
                    _statusbar,
                    style: TextStyle(
                        letterSpacing: 1.4,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 30),
                  )),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: infoModel.length,
                  itemBuilder: (_, index) {
                    return Container(
                        padding: EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  color: Colors.amber[600],
                                  width: 3,
                                  height: 40,
                                ),
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.amber[600],
                                ),
                                Container(
                                  color: Colors.amber[600],
                                  width: 3,
                                  height: 40,
                                )
                              ],
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding:
                                          EdgeInsets.only(left: 10, bottom: 5),
                                      child: Text(infoModel[index].comment,
                                          style: TextStyle(
                                              color: Colors.grey[900],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18))),
                                  Container(
                                      padding:
                                          EdgeInsets.only(left: 10, bottom: 5),
                                      child: Text(
                                          '${infoModel[index].date}, ${infoModel[index].time}',
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15))),
                                  Container(
                                      padding:
                                          EdgeInsets.only(left: 10, bottom: 5),
                                      child: Text(infoModel[index].location,
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.normal,
                                              fontSize: 17))),
                                ])
                          ],
                        ));
                  }),
            ),
          ],
        ));
  }
}
