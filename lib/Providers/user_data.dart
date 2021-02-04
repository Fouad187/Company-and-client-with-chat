import 'package:flutter/cupertino.dart';
import 'package:injaz/Models/user_model.dart';

class UserData extends ChangeNotifier
{
  UserModel user=UserModel();

  setUser(UserModel mod)
  {
    this.user=mod;
  }


}