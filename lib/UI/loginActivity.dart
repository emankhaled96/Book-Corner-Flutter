import 'package:book_corner/Controller/dioclient.dart';
import 'package:book_corner/UI/allBooks.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/User.dart';

class LoginActivity extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LoginActivityState();
  }

}
class LoginActivityState extends State<LoginActivity>{
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late DioClient dioClient;
  late String token;
  // getPref()async{
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   token = sharedPreferences.getString("token")!;
  //   print("Token:$token");
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getPref();
   // var prefs =  SharedPreferences.getInstance();
   //
   //  prefs.then((value) => {
   //    if(value.getString("token")!="null"){
   //
   //      print(value.getString("token"))
        // Navigator.of(context).push(new MaterialPageRoute(
        // builder: (BuildContext context)=>new AllBooks(value.getString("token"))
    // )
    //     )
      //}
    //});
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
    dioClient = DioClient();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(18, 93, 152, 1),
        title: Text("Books Corner"),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/registerbackground.png"),
                fit: BoxFit.cover)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(padding: EdgeInsets.only(top: 20.0)),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Email",
                contentPadding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                hintStyle: TextStyle(
                  color: Color.fromRGBO(18, 93, 152, 1),
                  fontSize: 20.0,
                ),
                fillColor: Color.fromRGBO(148, 218, 255, 1),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: "Password",
                contentPadding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                hintStyle: TextStyle(
                  color: Color.fromRGBO(18, 93, 152, 1),
                  fontSize: 20.0,
                ),
                fillColor: Color.fromRGBO(148, 218, 255, 1),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 30.0)),
            ElevatedButton(
              onPressed: (){
                Future<User> user = dioClient.login(_emailController.text, _passwordController.text,context);
                user.then((value) =>
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context)=>new AllBooks(value.token)
                    )
                    ));

              },
              child: Text("Login"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                textStyle: TextStyle(fontSize: 18.0),
                primary: Color.fromRGBO(250, 200, 177, 1),
                onPrimary: Color.fromRGBO(18, 93, 152, 1),
              ),
            )
          ],
        ),
      ),
    );
  }

}