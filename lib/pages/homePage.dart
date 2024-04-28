import 'package:flutter/material.dart';
import 'package:testapp/widgets/drawer_widget.dart';

class HomePage extends StatelessWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(

      ),
      appBar: AppBar(title: Text("Home Page"),),
      body: Center(child: Text("This page will try to make your life easier",
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      ),
    );
  }
}