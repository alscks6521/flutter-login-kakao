import 'package:flutter/foundation.dart';

class UserModel with ChangeNotifier {
  String nickname;
  String email;
  List<String>? friends;

  UserModel({required this.nickname, required this.email, this.friends});

  //
}
