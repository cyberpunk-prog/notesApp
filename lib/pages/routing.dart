import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:task2/custom/custButton.dart';
import 'package:task2/pages/signin.dart';

import 'signup.dart';

class Routing extends StatelessWidget {
  static String id = 'routePage';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(tag: 'image1', child: Image.asset('images/image1.png')),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              //width: 250.0,
              child: TextLiquidFill(
                text: 'TASK MANAGER',
                waveColor: Colors.black,
                boxBackgroundColor: Colors.white,
                textStyle: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
                boxHeight: 100.0,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            CustomButton(
              onPressed: () => {Navigator.pushNamed(context, SigInPage.id)},
              text: 'Sign in',
            ),
            CustomButton(
              onPressed: () => {Navigator.pushNamed(context, SigUpPage.id)},
              text: 'Sign Up',
            ),
          ],
        ),
      ),
    );
  }
}
