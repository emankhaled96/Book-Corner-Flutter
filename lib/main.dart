import 'package:book_corner/UI/RegisterActivity.dart';
import 'package:book_corner/UI/allBooks.dart';
import 'package:book_corner/UI/loginActivity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Controller/sessionManager.dart';
import 'UI/loginActivity.dart';

void main() async{

  runApp(
    MaterialApp(
      home: MyApp(),
      title: "Register",
      debugShowCheckedModeBanner: false,
    )
  );
}

class MyApp extends StatelessWidget{
  Future<String?>? getPrefs() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var token= prefs.getString("token");
      print("Token : $token");
      return token;
    }catch(e){

      return null;
    }

  }
  @override
  Widget build(BuildContext context) {

     Future<String?>? token = getPrefs();
     print("Token from $token");
    if(token ==null){
      return  MaterialApp(

          home: LoginActivity()
      );
    }else{
      return MaterialApp(

          home: AllBooks(token.toString())
      );

    }

    // TODO: implement build

  }

}
