import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class LoginFieldsManager extends Object with Validators{
  //email
  BehaviorSubject<String> emailController= new BehaviorSubject();
  Function get changeEmail=>emailController.sink.add;
  Stream<String> get emailStream=>emailController.stream.transform(emailValidatior);
  String get emailValue=>emailController.value;

  //password
  BehaviorSubject<String> passwordController=new BehaviorSubject();
  Function get changePassword=> passwordController.sink.add;
  Stream<String> get passwordStream=> passwordController.stream.transform(passwordValidator);
  String get passwordValue=>passwordController.value;

  //loginValid
  Stream<bool> get loginValid=>CombineLatestStream.combine2(emailStream, passwordStream, (e,p)=>true);
}

class RegisterFieldManager extends Object with Validators{
  //email
  BehaviorSubject<String> emailController= new BehaviorSubject();
  Function get changeEmail=>emailController.sink.add;
  Stream<String> get emailStream=>emailController.stream.transform(emailValidatior);
  String get emailValue=>emailController.value;

  //password
  BehaviorSubject<String> passwordController=new BehaviorSubject();
  Function get changePassword=> passwordController.sink.add;
  Stream<String> get passwordStream=> passwordController.stream.transform(passwordValidator);
  String get passwordValue=>passwordController.value;

  //Phone Number
  BehaviorSubject<String> phoneNumberController=new BehaviorSubject();
  Function get changePhoneNumber=> phoneNumberController.sink.add;
  Stream<String> get phoneNumberStream=> phoneNumberController.stream.transform(phoneNumberValidator);
  String get phoneNumberValue=> phoneNumberController.value;

  //re enter password
  BehaviorSubject<String> reEnterPasswordController=new BehaviorSubject();
  Function get changeReEnterPassword=> reEnterPasswordController.sink.add;
  Stream<String> get reEnterPasswordStream=>reEnterPasswordController.stream.transform(passwordValidator);
  String get reEnterPasswordValue=> reEnterPasswordController.value;

  //firstname controller
  BehaviorSubject<String> firstNameController=new BehaviorSubject<String>();
  Function get changeFirstName=>firstNameController.sink.add;
  Stream<String> get firstNameStream=> firstNameController.stream.transform(nameValidator);
  String get firstNameValue=>firstNameController.value;

  //second name
  BehaviorSubject<String> secondNameController=new BehaviorSubject<String>();
  Function get changeSecondName=>secondNameController.sink.add;
  Stream<String> get secondNameStream=> secondNameController.stream.transform(nameValidator);
  String get secondNameValue=> secondNameController.value;

  Stream<bool>get registerValid=> CombineLatestStream.combine6(
    firstNameStream, 
    secondNameStream, 
    phoneNumberStream, 
    emailStream, 
    passwordStream, 
    reEnterPasswordStream, 
    (a,b,c,d,e,f)=>true);

}




class Validators{
  //email validator
  StreamTransformer<String,String> emailValidatior= new StreamTransformer<String,String>.fromHandlers(
    handleData: (value,sink){
      if(value.contains('@')) sink.add(value);
      else sink.addError('invalid email address');
    }
  );
  //password validator
  StreamTransformer<String,String> passwordValidator=new StreamTransformer<String,String>.fromHandlers(
    handleData: (value,sink)
    {
      if(value.length<8) sink.addError('password length at least 8 characters');
      else sink.add(value);
    }
  );
  //phone number validator
  StreamTransformer<String,String> phoneNumberValidator=new StreamTransformer<String,String>.fromHandlers(
    handleData: (value,sink){
      if (value.length==11)
      {
        try{
          int.parse(value.substring(1));
          sink.add(value);
        }
        catch(e)
        {
          sink.addError("invalid Phone Number");
        }
      }
      else{
        sink.addError("invalid Phone Number");
      }
    }
  );
  //name validator
  StreamTransformer<String,String> nameValidator=new StreamTransformer<String,String>.fromHandlers(
    handleData: (value,sink){
      if(value.length>0) sink.add(value); else sink.addError("enter a name");
    }
  );
}

