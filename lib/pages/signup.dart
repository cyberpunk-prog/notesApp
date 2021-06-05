import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task2/custom/custButton.dart';
import 'package:task2/custom/customTextField.dart';

import 'landingPage.dart';

class SigUpPage extends StatefulWidget {
  static String id = 'signupPage';

  @override
  _SigUpPageState createState() => _SigUpPageState();
}

class _SigUpPageState extends State<SigUpPage> {
  var email, password;

  final _auth = FirebaseAuth.instance;

  Future registerUser() async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Navigator.pop(context);
      Navigator.pushNamed(context, LandingPage.id);
    } catch (e) {
      print(e.toString());
      Navigator.pop(context);
    }
  }

  void showSpinner() {
    setState(() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(child: CircularProgressIndicator());
          });
    });
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
                  Hero(tag: 'image1', child: Image.asset('images/image1.png')),
              height: 300.0,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextWidget(
              hintField: 'Enter your email',
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
            // ignore: missing_required_param
            CustomButton(
              onPressed: () async {
                showSpinner();
                await registerUser();
              },
              text: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
