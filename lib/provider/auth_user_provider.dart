import 'package:flutter/material.dart';
import 'package:task_management/model/my_user.dart';

class AuthUserProvider extends ChangeNotifier {
  MyUser? currentUser;

  void setCurrentUser(MyUser user) {
    currentUser = user;
    notifyListeners();
  }
}
