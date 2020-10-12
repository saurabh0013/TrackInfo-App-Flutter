import 'package:flutter/material.dart';
import 'package:track_info/animations/FadeAnimation.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: SingleChildScrollView(
                child: Column(
                children: [
                  Container(
                    color: Colors.amber[600],
                    child: Padding(
                      padding: const EdgeInsets.only(top:40,bottom: 40),
                      child: Column(
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FadeAnimation(0.2,
                                Icon(
                                  Icons.location_on,
                                  size: 150,
                                  color: Colors.white,
                                  )
                                ),
                            ],
                          ),
                           FadeAnimation(0.3,Text("About Us",
                              style:TextStyle(
                              fontSize: 60,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                              )
                            ),
                           ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal : 18.0,vertical: 20),
                      child: FadeAnimation(1.2, Column(
                          children: [
                            Text("This App is made as the MINOR PROJECT of our 5th semester. It is made for fetching tracking details of some widely used courier services within this single app. A couple of API's used in this app is provided by their respective services rest are custom made using the technique of web scraping.\n\nFor detailed information kindly look for our source code through the given Github repo link at the bottom. The sorce code and api is made open source. If anyone wants to use the source code for development pupose you can use it. \n\nTo appericate the work of our developers and give us your valuable feedback go to the feedback section",
                            style:TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]
                            ) ,),
                            SizedBox(height: 10),
                            Text('DEVELOPERS',
                            style:TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600]
                            ) ,),
                            SizedBox(height: 10),
                            Text("Saurabh Pratap Singh | Shashwat",
                            style:TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600]
                            ) ,),
                            SizedBox(height: 5),
                            
                            Text("Shivani Priya | Shaurya Mukund",
                            style:TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600]
                            ) ,),
                            
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    )
                  )
                ],
              ),
            ),
    );
  }
}