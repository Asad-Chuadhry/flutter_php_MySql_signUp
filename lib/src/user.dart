
class UserModel{
  final int id;
  final String firstname;
  final String secondname;
  final String phonenumber;
  final String email;
  final String password;
  final DateTime regDate;
  UserModel.fromJson(Map<String,dynamic> parsedJson): 
  id= int.parse(parsedJson['id']),
  firstname=parsedJson['firstname'],
  secondname=parsedJson['secondname'],
  phonenumber=parsedJson['phonenumber'],
  email=parsedJson['email'],
  password=parsedJson['password'],
  regDate=DateTime.parse(parsedJson['reg_date']);
}