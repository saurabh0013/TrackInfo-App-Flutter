import 'package:flutter/material.dart';
import 'package:track_info/animations/FadeAnimation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wiredash/wiredash.dart';

class MyAboutUs extends StatelessWidget {
  final _navigatorkey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Wiredash(
      secret: '7l3zqbhgcvzt9cr1od7u1fcbsd16vcwr',
      projectId: 'trackinfo-app-5m64eqx',
      navigatorKey: _navigatorkey,
      child: MaterialApp(
        navigatorKey: _navigatorkey,
        home: AboutUs(),
      ),
    );
  }
}

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange[400],
          onPressed: () => Wiredash.of(context).show(),
          child: Icon(Icons.question_answer_outlined, color: Colors.white)),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                      0.3,
                      Text("About Us",
                          style: TextStyle(
                              fontSize: 60,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
              child: FadeAnimation(
                1.2,
                Column(
                  children: [
                    Text(
                      "This App is written in Dart language using Flutter SDK which is an open-source UI software development kit created by Google. Using this app you can get tracking details of some widely used courier services in India from one app. API's used in this app is written in Node.js which is a JavaScript library. Web scraping is used to scrape data from the courier websites.\n\nTo get source code of this app click on the Github icon at the bottom. The sorce code for the App and APIs is available on Github.\n\nTo appericate the work of our developers kindly give us your valuable feedback by tapping the chat button .",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600]),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'DEVELOPERS',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600]),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Saurabh Pratap Singh | Shashwat",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600]),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Shivani Priya | Shaurya Mukund",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600]),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        launch('https://github.com/saurabh0013/track_info');
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              child: Image.asset(
                                'assets/github.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                            Text(
                              'GitHub',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  letterSpacing: 0.7),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
