import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'model.dart';

class User extends Model {
  String name;
  String email;
  String password;
  Uint8List? picture;

  User({
    String? id,
    required this.name,
    required this.email,
    required this.password,
    File? picture,
  })  : picture = picture?.readAsBytesSync(),
        super(id: id);

  @override
  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        password = json['password'],
        picture =
        json['picture'] != null ? base64Decode(json['picture']) : null,
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'email': email,
    'password': password,
    'picture': picture != null ? base64Encode(picture!) : null,
    'id': id,
  };

  void updatePicture(File picture) {
    this.picture = picture.readAsBytesSync();
  }
}
