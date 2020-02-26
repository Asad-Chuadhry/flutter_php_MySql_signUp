import 'package:flutter/material.dart';
import '../user.dart';
class HomeScreen extends StatefulWidget{
 final UserModel user;
  HomeScreen(this.user);
  _HomeScreenState createState()=> _HomeScreenState(user);

}
class _HomeScreenState extends State<HomeScreen>{
  UserModel user;
  _HomeScreenState(this.user);
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(user.firstname),
        leading: Icon(Icons.photo,color: Colors.white),
        actions: <Widget>[
          RaisedButton(
            onPressed: (){
              Navigator.pushReplacementNamed(context, '/loginScreen');
            },
            textColor: Colors.white,
            color: Colors.purple[900],
            child: Text('logout', 
              style: TextStyle(
                backgroundColor: Colors.purple[900]
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width/3,
            top: MediaQuery.of(context).size.width/3
            ),
          child: Column(
          children: <Widget>[
            //name
            Row(
              children: <Widget>[
                Icon(Icons.photo),
                Container(width: 20,),
                Text(user.firstname+" "+user.secondname),
              ],
            ),
            //phone number
            Row(
              children: <Widget>[
                Icon(Icons.contact_phone),
                Container(width: 20,),
                Text(user.phonenumber)
              ],
            ),
            //email
            Row(
              children: <Widget>[
                Icon(Icons.email),
                Container(width: 20,),
                Text(user.email)
              ],
            ),
            //registeration date
            Row(
              children: <Widget>[
              Icon(Icons.date_range),
              Container(width: 20,),
              Text("Join at "+user.regDate.toString())
            ],
            )
          ],
        ),
        )
      )
    );
  }
}