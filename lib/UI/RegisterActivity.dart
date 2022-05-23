import 'package:book_corner/Controller/dioclient.dart';
import 'package:book_corner/Model/User.dart';
import 'package:book_corner/UI/loginActivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';

class RegisterActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterActivityState();
  }
}

class RegisterActivityState extends State<RegisterActivity> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late DioClient dioClient ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = new TextEditingController();
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
    dioClient = new DioClient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(18, 93, 152, 1),
        title: Text("Books Corner"),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/registerbackground.png"),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Name",
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
              onPressed: _register,
              child: Text("REGISTER"),
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

  void _register() {
    String name = _nameController.text.toString();
    String email = _emailController.text.toString();
    String pass = _passwordController.text.toString();

    print('$name');

    if (name.isEmpty || email.isEmpty || pass.isEmpty) {
      print('${name}  ${email}  ${pass}');
      Fluttertoast.showToast(
        msg: "Please Enter Your Information", // message
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.BOTTOM, // location
      );
    } else {



     dioClient.createUser(name, email, pass).then((value) =>
         Navigator.of(context).push(new MaterialPageRoute(
         builder: (BuildContext context)=>new LoginActivity()
     )
     )) ;

    }
  }

  // actions: [
  // PopupMenuButton<int>(
  // onSelected: (item) => onSelected(context, item),
  // itemBuilder: (context) =>
  // [PopupMenuItem(value: 0, child: Text("Logout"))])
  // ],
  // void onSelected(BuildContext context,int item) {
  //   switch (item) {
  //     case 0:
  //       print("Logout Clicked");
  //       break;
  //   }
  // }
}
