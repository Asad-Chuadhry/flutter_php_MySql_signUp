import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../fieldManager.dart';
import 'dart:convert';
import '../user.dart';
import '../screens/home.dart';
class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState()=> _LoginScreenState();
  }
class _LoginScreenState extends State<LoginScreen>{
  final LoginFieldsManager loginFieldManager=new LoginFieldsManager();
  final textContentPadding= EdgeInsets.fromLTRB(45.0, 10.0, 20.0, 10.0);
  final textStyle=TextStyle(fontSize: 16);
  UserModel user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          RaisedButton(
            onPressed: (){
              Navigator.pushReplacementNamed(context, '/signUpScreen');
            },
            textColor: Colors.white,
            color: Colors.purple[900],
            child: Text('Sign Up', 
              style: TextStyle(
                backgroundColor: Colors.purple[900]
              ),
            ),
          )
        ],
      ),
      body: body(),
    );
  }
  Widget body()
  {
    final emailField= StreamBuilder(
      stream: loginFieldManager.emailStream,
      builder: (context,snapshot){
        return TextField(
          onChanged: loginFieldManager.changeEmail,
    style: textStyle,
    decoration: InputDecoration(
      contentPadding: textContentPadding,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      hintText: 'Email',
      labelText: 'Email',
      errorText:snapshot.error,
      ),
      keyboardType: TextInputType.emailAddress,
      keyboardAppearance: Brightness.dark,
    );
      },
    );
    final passwordField= StreamBuilder(
      stream: loginFieldManager.passwordStream,
      builder: (context,snapshot){
        return TextField(
          onChanged: loginFieldManager.changePassword,
    style: textStyle,
    decoration: InputDecoration(
      contentPadding: textContentPadding,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      hintText: 'Passwsord',
      labelText: 'Password',
      errorText: snapshot.error
      ),
    );
      },
    );
    final loginButton=StreamBuilder(
      stream: loginFieldManager.loginValid,
      builder: (context,snapshot){
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          onPressed: (snapshot.hasData)?(){
            loginUser();
          }:null,
          child: Text("Login",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16),
          ),
          color: Colors.purple[900],
        ),
        );
      },
    );
    return SingleChildScrollView(
    child: Center(
      child: Container(
        padding: EdgeInsets.all(40),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 155,
                child: Image.asset('assets/images/logo1.png',
                  fit: BoxFit.contain,),
              ),
              SizedBox(height: 40,),
              emailField,
              SizedBox(height: 20,),
              passwordField,
              SizedBox(height: 45,),
              loginButton
            ],
          ),
      )
    ),
  );
  }
  void loginUser()async{
    final response= await http.get("http://10.0.2.2/registerationf/User/${loginFieldManager.emailValue+loginFieldManager.passwordValue}.json");
    if(response.statusCode==200)
    {
      user=new UserModel.fromJson(json.decode(response.body));
      Navigator.pushReplacement(context,MaterialPageRoute(
        builder: (context)=>HomeScreen(user))

      );

    }
    else
    print("error");
  }
}