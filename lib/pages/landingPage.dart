import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task2/pages/taskCreate.dart';

class LandingPage extends StatefulWidget {
  static String id = 'landingPage';

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _auth = FirebaseAuth.instance;

  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    printUser();
  }

  late User loggedInUser;

  void printUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Task'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('adding task');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateTask()),
          );
        },
        child: Icon(Icons.edit),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users2').snapshots(),
        builder: (context, snapshot) {
          var messageTitle, messageBody, messageUser;
          List<Widget> messageWidgets = [];
          if (snapshot.hasData) {
            final messages = snapshot.data!.docs.reversed;

            for (var message in messages) {
              messageTitle = message.get('title');
              messageBody = message.get('body');
              messageUser = message.get('user');
              // final messageWidget = Text(
              //     'title: $messageTitle, body: $messageBody by-$messageUser ');
              if (loggedInUser.email == messageUser)
                messageWidgets.add(
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Center(
                              child: Text(
                            messageTitle,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 200,
                              child: ListView(children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(messageBody),
                                )
                              ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 30,
                              child: Text('- $messageUser'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
            }
          } else {
            return CircularProgressIndicator();
          }
          return ListView(
            children: messageWidgets,
            // padding: EdgeInsets.symmetric(vertical: 20),
          );
        },
      ),
    );
  }
}
