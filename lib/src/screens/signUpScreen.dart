import 'package:flutter/material.dart';
import 'package:signup_php/sizeConfig.dart';
import '../fieldManager.dart' ;
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget{
  _SignUpScreenState createState()=> _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen>{
  final RegisterFieldManager registerFieldManager=new RegisterFieldManager();
  final textContentPadding= EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0);
  final textStyle=TextStyle(fontSize: 16);
  double heightMultiple;
  double widthMultiple;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthMultiple=SizeConfig.blockSizeHorizontal;
    heightMultiple=SizeConfig.blockSizeVerticle;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          RaisedButton(
            onPressed: (){
              Navigator.pushReplacementNamed(context, '/loginScreen');
            },
            textColor: Colors.white,
            color: Colors.purple[900],
            child: Text('Login', 
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
    final firstNameField= SizedBox(
      width: MediaQuery.of(context).size.width/2.35,
      child: StreamBuilder(
        stream: registerFieldManager.firstNameStream,
        builder: (context,snapshot){
          return TextField(
    style: textStyle,
    onChanged: registerFieldManager.changeFirstName,
    decoration: InputDecoration(
      contentPadding: textContentPadding,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      hintText: 'First Name',
      labelText: 'First Name',
      errorText: snapshot.error
      ),
    );
        },
      ),
    );

    final secondNameField= SizedBox(
      width:( MediaQuery.of(context).size.width/2.5),
      child: StreamBuilder(
        stream: registerFieldManager.secondNameStream,
        builder: (context,snapshot){
          return TextField(
    onChanged: registerFieldManager.changeSecondName,
    style: textStyle,
    decoration: InputDecoration(
      contentPadding: textContentPadding,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      hintText: 'Last Name',
      labelText: 'Last Name',
      errorText: snapshot.error
      ),
    );
        },
      ),
    );

    final phoneNumberField=SizedBox(
      width:( MediaQuery.of(context).size.width),
      child: StreamBuilder(
        stream: registerFieldManager.phoneNumberStream,
        builder: (context,snapshot){
          return TextField(
    style: textStyle,
    onChanged:(value)=> registerFieldManager.changePhoneNumber("0$value"),
    decoration: InputDecoration(
      prefixText: "+92",
      contentPadding: textContentPadding,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      hintText: 'Phone Number',
      labelText: 'Phone Number',
      errorText: snapshot.error
      ),
      keyboardType: TextInputType.phone,
    );
        },
      )
    );

    final emailField=SizedBox(
      width:( MediaQuery.of(context).size.width),
      child: StreamBuilder(
        stream: registerFieldManager.emailStream,
        builder: (context,snapshot){
          return TextField(
    style: textStyle,
    onChanged: registerFieldManager.changeEmail,
    decoration: InputDecoration(
      contentPadding: textContentPadding,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      hintText: 'Email',
      labelText: 'Email',
      errorText: snapshot.error
      ),
      keyboardType: TextInputType.emailAddress,
    );
        },
      )
    );
      final passwordField= StreamBuilder(
      stream: registerFieldManager.passwordStream,
      builder: (context,snapshot){
        return TextField(
          onChanged: registerFieldManager.changePassword,
    style: textStyle,
    decoration: InputDecoration(
      contentPadding: textContentPadding,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      hintText: 'Password',
      labelText: 'Password',
      errorText: snapshot.error
      ),
    );
      },
    );

    final reEnterpasswordField=SizedBox(
      width:( MediaQuery.of(context).size.width),
      child: StreamBuilder(
        stream: registerFieldManager.reEnterPasswordStream,
        builder: (context,snapshot){
          return TextField(
    style: textStyle,
    onChanged: registerFieldManager.changeReEnterPassword,
    decoration: InputDecoration(
      contentPadding: textContentPadding,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      hintText: 'Re-Enter Password',
      labelText: 'Re-Enter Password',
      errorText: snapshot.error
      ),
    );
        },
      )
    );

  final registerButton=StreamBuilder(
      stream: registerFieldManager.registerValid,
      builder: (context,snapshot){
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          onPressed: (snapshot.hasData)?(){
            if(registerFieldManager.passwordValue!=registerFieldManager.reEnterPasswordValue)
            {
                showDialog(context:context,
                barrierDismissible: true,
                child: AlertDialog(
                title: Text("Password not Matched"),
                content: Text("Re-Enter your password"),
                actions: <Widget>[RaisedButton( 
                  color: Colors.purple[900],
                  textColor: Colors.white,
                  child: Text("OK"),
                  onPressed:(){ Navigator.of(context).pop();},
                )],
              ));
              
            }
            else{
              registerUser();
            }
          }:null,
          child: Text("Register",
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
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        child: Form( child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                firstNameField,
                SizedBox(width: 15,),
                secondNameField
            ],),
            SizedBox(height: 20,),
            phoneNumberField,
            SizedBox(height: 20,),
            emailField,
            SizedBox(height: 20,),
            passwordField,
            SizedBox(height: 20,),
            reEnterpasswordField,
            SizedBox(height: 30),
            registerButton
          ],
        ),)
      ),
    );
  }
  void registerUser() async {
    var uriResponse =await http.post("http://10.0.2.2/registerationf/insertData.php",
      body: {
        "firstname": registerFieldManager.firstNameValue,
        "secondname": registerFieldManager.secondNameValue,
        "phonenumber": registerFieldManager.phoneNumberValue,
        "email": registerFieldManager.emailValue,
        "password": registerFieldManager.passwordValue
      });
      if(uriResponse.statusCode==200)
     { 
       if(uriResponse.body.toString().contains('Duplicate entry'))
       {
         showDialog(context:context,
                barrierDismissible: true,
                child: AlertDialog(
                title: Text("Registeration Failed"),
                content: Text("A User already Register with this email "),
                actions: <Widget>[RaisedButton( 
                  color: Colors.purple[900],
                  textColor: Colors.white,
                  child: Text("OK"),
                  onPressed:(){ Navigator.of(context).pop();},
                )],
              ));
       } 
       else{
            showDialog(context:context,
                barrierDismissible: false,
                child: AlertDialog(
                title: Text("Register Sucessfully"),
                content: Text("Welcome, Thankyou for joining us"),
                actions: <Widget>[RaisedButton( 
                  color: Colors.purple[900],
                  textColor: Colors.white,
                  child: Text("OK"),
                  onPressed:(){ Navigator.pushReplacementNamed(context, '/loginScreen');},
                )],
              ));
       }     
     }
              else
          { 
              print(uriResponse.body.toString());  
              showDialog(context:context,
                barrierDismissible: true,
                child: AlertDialog(
                title: Text("Network Error"),
                content: Text("Try again with internet connection"),
                actions: <Widget>[RaisedButton( 
                  color: Colors.purple[900],
                  textColor: Colors.white,
                  child: Text("OK"),
                  onPressed:(){ Navigator.of(context).pop();},
                )],
              ));
          }
  }
}