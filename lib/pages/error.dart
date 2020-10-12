import 'package:flutter/material.dart';
import 'package:track_info/animations/FadeAnimation.dart';
class Error extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details Not Found",
        style:TextStyle(
          fontSize: 25,
          letterSpacing: 1.1,
          color: Colors.white,
          fontWeight: FontWeight.bold
        ) ,), backgroundColor: Colors.amber[600],),
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
                           FadeAnimation(0.3,Text("oops!",
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
                            Container(
                              height: 250,
                              width: 200,
                              child: Center(
                                child:Image.asset('assets/error.png',
                                fit: BoxFit.contain,),
                            ),),
                            Center(
                              child: Text("\nInvalid Id/Unsupported Service",
                              style:TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.red
                              ) ,),
                            ),
                            Center(
                              child: Text("\nDetails not available.\nEither your Tracking Id is invalid or the service you are requesting is Currently not Supported.",
                              style:TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600]
                              ) ,),
                            ),
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