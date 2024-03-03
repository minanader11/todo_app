import 'package:flutter/material.dart';
import 'package:todo_app/features/Home/data/user_model.dart';

class AuthProviders extends ChangeNotifier{
  MyUser? user;
  void updateUser(MyUser newUser){
    user=newUser;
    notifyListeners();
  }
}