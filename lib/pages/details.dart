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
    Color statusbarColor;
    if (infoModel[0].status.toUpperCase() == 'DELIVERED' ||
        infoModel[0].status.toUpperCase() == 'OUT FOR DELIVERY')
      statusbarColor = Colors.green;
    else if (infoModel[0].status.toUpperCase() == 'RETURNED')
      statusbarColor = Colors.red;
    else
      statusbarColor = Colors.blue;
    return Scaffold(
        appBar: AppBar(
          title: Text(label),
          backgroundColor: Colors.amber[600],
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
                        color: Colors.grey[800],
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
                    infoModel[0].status.toUpperCase(),
                    style: TextStyle(
                        letterSpacing: 1.8,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 35),
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
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17))),
                                  Container(
                                      padding:
                                          EdgeInsets.only(left: 10, bottom: 5),
                                      child: Text(
                                          'Date : ${infoModel[index].date}, Time: ${infoModel[index].time}',
                                          style: TextStyle(
                                              color: Colors.grey[700],
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15))),
                                  Container(
                                      padding:
                                          EdgeInsets.only(left: 10, bottom: 5),
                                      child: Text(infoModel[index].location,
                                          style: TextStyle(
                                              color: Colors.grey[700],
                                              fontWeight: FontWeight.w500,
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
