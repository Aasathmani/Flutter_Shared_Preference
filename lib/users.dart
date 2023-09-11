import 'package:flutter/material.dart';

class Users {
  String Name,Email,Phone;

  Users(this.Name, this.Email, this.Phone);

  //constructor convert to json object instance
  Users.fromJson(Map<String,dynamic>json): Name=json['name'],Email=json['email'],Phone=json['phone'];

  //object to json string
  Map<String,dynamic> toJson()=>{
    'name':Name,
    'email':Email,
    'phone':Phone,
  };


}