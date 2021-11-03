import 'dart:io';
import 'dart:typed_data';

import 'model.dart';

class User extends Model {
  String name;
  //String email;
  String password;
  Uint8List? picture;

  User({
    String? id,
    required this.name,
    required this.password,
    File? picture,
  })  : picture = picture?.readAsBytesSync(),
        super(id: id);


  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        password = json['password'];

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'password': password,
  };

  void updatePicture(File picture) {
    this.picture = picture.readAsBytesSync();
  }
}
