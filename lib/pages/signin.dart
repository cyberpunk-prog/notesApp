import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task2/custom/custButton.dart';
import 'package:task2/custom/customTextField.dart';
import 'package:task2/pages/landingPage.dart';

class SigInPage extends StatefulWidget {
  static String id = 'signinPage';

  @override
  _SigInPageState createState() => _SigInPageState();
}

class _SigInPageState extends State<SigInPage> {
  var email, password;
  final _auth = FirebaseAuth.instance;

  void showSpinner() {
    setState(() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(child: CircularProgressIndicator());
          });
    });
  }

  Future signInUser() async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.pop(context);
      Navigator.pushNamed(context, LandingPage.id);
    } catch (e) {
      print(e.toString());
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child:
                  Hero(tag: 'image1', child: Image.asset('images/image2.png')),
              height: 300.0,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextWidget(
              hintField: 'Enter your Email',
              obscureField: false,
              onChanged: (value) {
                email = value;
              },
            ),
            CustomTextWidget(
              hintField: 'Enter your password',
              obscureField: true,
              onChanged: (value) {
                password = value;
              },
            ),
            SizedBox(
              height: 100,
            ),
            CustomButton(
              onPressed: () async {
                showSpinner();
                await signInUser();
              },
              text: 'Sign in',
            ),
          ],
        ),
      ),
    );
  }
}
