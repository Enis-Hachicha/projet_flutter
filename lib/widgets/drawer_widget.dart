import 'package:flutter/material.dart';


class MyDrawer extends StatelessWidget{
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Drawer(
        child: ListView(
          children:[
            const DrawerHeader(
                decoration: BoxDecoration(
                    gradient:  LinearGradient(
                        colors: [
                          Color.fromRGBO(143, 148, 251, 1),
                          Color.fromRGBO(143, 148, 251, .6),
                        ]
                    )
                ),
                child: Column(
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/pp.jpg"),
                        radius: 50,
                      ),
                    ),
                    Text("Enis Hachicha")
                  ],
                ),

            )
            ,
            ListTile(
              title: Text("Accueil", style: TextStyle(fontSize: 26),),
              leading: Icon(Icons.home, color: Colors.purpleAccent,),
              trailing: Icon(Icons.arrow_right,color: Colors.grey,),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.pushNamed(context, "/home");

              },
            ),
            Divider(height: 5, color: Colors.black,),
            ListTile(
              title: Text("Tasks", style: TextStyle(fontSize: 26),),
              leading: Icon(Icons.voice_chat_rounded, color: Colors.purpleAccent),
              trailing: Icon(Icons.arrow_right,color: Colors.grey,),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.pushNamed(context, "/tasks");
              },
            ),
            Divider(height: 5, color: Colors.black,),
            ListTile(
              title: Text("Journal", style: TextStyle(fontSize: 26),),
              leading: Icon(Icons.voice_chat_rounded, color: Colors.purpleAccent),
              trailing: Icon(Icons.arrow_right,color: Colors.grey,),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.pushNamed(context, "/journal");
              },
            ),
            Divider(height: 5, color: Colors.black,),
            ListTile(
              title: Text("Déconnexion", style: TextStyle(fontSize: 26),),
              leading: Icon(Icons.close, color: Colors.purpleAccent),
              trailing: Icon(Icons.arrow_right,color: Colors.grey,),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.pushNamed(context, "/login");
              },
            )
          ],
        )
    );
  }
}