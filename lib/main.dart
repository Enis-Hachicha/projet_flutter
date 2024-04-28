import 'package:flutter/material.dart';
import 'package:testapp/pages/homePage.dart';
import 'package:testapp/pages/Tasks.dart';
import 'package:testapp/pages/Journal.dart';

void main() {
  runApp(testapp());
}

class testapp extends StatelessWidget {
  const testapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/home": (context){
          return HomePage();
        },
        "/tasks": (context){
          return Tasks();
        },
        "/journal": (context){
          return Journal();
        }
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      initialRoute: "/home",
    );
  }
}