import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task2/pages/landingPage.dart';
import 'package:task2/pages/signin.dart';

import 'pages/routing.dart';
import 'pages/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routing.id,
      routes: {
        SigInPage.id: (context) => SigInPage(),
        Routing.id: (context) => Routing(),
        SigUpPage.id: (context) => SigUpPage(),
        LandingPage.id: (context) => LandingPage(),
      },
    );
  }
}
