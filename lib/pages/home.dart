import 'package:flutter/material.dart';
import 'package:track_info/animations/FadeAnimation.dart';
import 'package:track_info/database/database_helper.dart';
import 'package:track_info/models/infoDatabaseModel.dart';
import 'package:track_info/models/infoModel.dart';
import 'package:track_info/pages/details.dart';
import 'package:track_info/services/trackingService.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:track_info/pages/error.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  final DatabaseHelper databaseHelper;

  const Home({Key key, this.databaseHelper}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Dropdown Menu List
  List<String> options = <String>[
    '-Select Courier-',
    'Blue Dart',
    'Delhivery',
    'DTDC',
    'Ekart',
    'Ecom Express',
    'Fedex',
    'India Post',
  ];
  String dropdownValue = '-Select Courier-';
  final _formKey = GlobalKey<FormState>();
  String _label = '';
  Color _color1 = Colors.amber;
  Color _color2 = Colors.red[300];
  String _trackingId = '';
  String _service;
  final _trackingService = TrackingService();
  ProgressDialog progressDialog;
  TextEditingController _controllerTrackingId = TextEditingController();
  TextEditingController _controllerLabel = TextEditingController();
  double _shadow = 18;

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(
        message: ' Tracking Your Parcel',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[400]),
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        messageTextStyle: TextStyle(
            color: Colors.orange[600],
            fontSize: 19.0,
            fontWeight: FontWeight.w600));

    //  print(_service);
    //  print(_trackingId);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
              Widget>[
            Container(
              color: Colors.orange[400],
              child: Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 40),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeAnimation(
                            0.2,
                            Icon(
                              Icons.location_on,
                              size: 150,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    FadeAnimation(
                      0.1,
                      Text("TrackInfo",
                          style: TextStyle(
                              fontSize: 60,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
              child: Column(children: <Widget>[
                FadeAnimation(
                  0.4,
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.orange[200],
                              blurRadius: 3,
                              offset: Offset(0, 2))
                        ]),
                    child: Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 8, 0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[100]))),
                          child: DropdownButtonFormField<String>(
                            validator: (value) {
                              print(value);
                              if (value == '-Select Courier-') {
                                return 'Please Select Courier';
                              }
                              return null;
                            },
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            value: dropdownValue,
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                                _service = newValue;
                              });
                            },
                            selectedItemBuilder: (BuildContext context) {
                              return options.map((String value) {
                                return Text(
                                  dropdownValue,
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                );
                              }).toList();
                            },
                            items: options
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: TextStyle(
                                        color: Colors.orange[400],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25)),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 8, 0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[100]))),
                          child: TextFormField(
                            validator: (value) {
                              print(value);
                              if (value == '') {
                                return 'Tracking Id cannot be empty';
                              }
                              return null;
                            },
                            controller: _controllerTrackingId,
                            style: TextStyle(fontSize: 23),
                            showCursor: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Tracking Id",
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 8, 0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[100]))),
                          child: TextField(
                            controller: _controllerLabel,
                            style: TextStyle(fontSize: 23),
                            showCursor: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Label (Optional)",
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                )
              ]),
            ),
            SizedBox(
              height: 30,
            ),
            FadeAnimation(
                0.5,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: GestureDetector(
                    onTapDown: (_) {
                      setState(() {
                        // _color1 = Colors.green;
                        // _color2 = Colors.blue[200];
                        _shadow = 0;
                      });
                    },
                    onTapUp: (_) async {
                      setState(() {
                        // _color1 = Colors.amber;
                        // _color2 = Colors.red[300];
                        _shadow = 8;
                      });
                      if (_formKey.currentState.validate()) {
                        progressDialog.show();
                        setState(() {
                          _trackingId = _controllerTrackingId.text.trim();
                          _label = _controllerLabel.text;
                        });
                        if (_service == 'Ecom Express') {
                          await progressDialog.hide();
                          await launch(
                              'https://ecomexpress.in/tracking/?awb_field=$_trackingId');

                          setState(() {
                            _controllerTrackingId.text = '';
                            _controllerLabel.text = '';
                            dropdownValue = options[0];
                          });
                        } else {
                          List<InfoModel> data = await _trackingService.track(
                              _trackingId, _service);

                          await progressDialog.hide();
                          setState(() {
                            _controllerTrackingId.text = '';
                            _controllerLabel.text = '';
                            dropdownValue = options[0];
                          });
                          if (data.isEmpty)
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Error()));
                          else {
                            DatabaseHelper databaseHelper =
                                widget.databaseHelper;
                            DatabaseModel databaseModel = DatabaseModel(
                                id: _trackingId,
                                label: _label,
                                date: data[0].date,
                                lastPlace: data[0].location,
                                status: data[0].comment,
                                time: data[0].time,
                                service: _service);
                            await databaseHelper.insertInfo(databaseModel);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Details(
                                    data, _label, _trackingId, _service)));
                          }
                        }
                      }
                    },
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[600],
                                blurRadius: _shadow,
                                offset: Offset(0, 0))
                          ],
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            _color1,
                            _color2,
                          ])),
                      child: Center(
                        child: Text(
                          'Track Shipment',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                )),
          ]),
        ),
      ),
    );
  }
}
