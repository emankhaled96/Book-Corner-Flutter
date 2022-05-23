import 'package:book_corner/UI/loginActivity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/User.dart';

class SessionManager{





  logout()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.clear();
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => LoginActivity()));
  }
   BuildContext context;
   SessionManager(this.context);
}