import 'package:flutter/material.dart';
import 'package:track_info/pages/about.dart';
import 'package:track_info/pages/support.dart';
import 'package:track_info/pages/home.dart';
import 'package:track_info/pages/saved.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final databaseHelper;

  MyBottomNavigationBar({Key key, this.databaseHelper}) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;
  List<Widget> _children;
  @override
  void initState() {
    super.initState();
    _children = [
      Home(
        databaseHelper: widget.databaseHelper,
      ),
      Saved(databaseHelper: widget.databaseHelper),
      MyAboutUs(),
      MyFeedback()
    ];
  }

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//   statusBarColor: Colors.grey[900], //or set color with: Color(0xFF0000FF)
// ));
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 50,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          backgroundColor: Colors.orange[400],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(.60),
          selectedFontSize: 18,
          unselectedFontSize: 14,
          onTap: onTappedBar,
          items: [
            BottomNavigationBarItem(
              label: 'Add New',
              icon: Icon(Icons.add),
            ),
            BottomNavigationBarItem(
              label: 'Saved',
              icon: Icon(Icons.favorite),
            ),
            BottomNavigationBarItem(
              label: 'About Us',
              icon: Icon(Icons.person),
            ),
            BottomNavigationBarItem(
              label: 'Support',
              icon: Icon(Icons.phone),
            ),
          ],
        ));
  }
}
