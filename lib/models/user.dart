import 'package:flutter/material.dart';

class User {
  final int id ;
  final String email;
  final String token;
  final String name;
   String type;

  User({@required this.id,@required this.email,@required this.token,@required this.name,@required this.type});

  User.fromJson(Map<String , dynamic> json) :
        id = json['id'],
        email = json['email'],
        token = json['token'],
        name = json['full_name'],
        type = json['userType'];

  Map<String , dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'email' : email,
    'token' : token,
    'userType' : type,
  };
}