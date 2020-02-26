import 'package:flutter/material.dart';
import '../src/screens/loginScreen.dart';
import '../src/screens/signUpScreen.dart';


class App extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData( 
        primaryColor: Colors.purple[900],
      ),
      home: LoginScreen(),
      routes: <String,WidgetBuilder>{
        '/loginScreen':(BuildContext context)=>new LoginScreen(),
        '/signUpScreen':(BuildContext context)=>new SignUpScreen(),
      },
    );
  }
}