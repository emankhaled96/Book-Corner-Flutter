import 'dart:io';
import 'dart:async';
import 'package:book_corner/UI/allBooks.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Controller/dioclient.dart';
import '../Model/Book.dart';

class AddBook extends StatefulWidget{
  String? token;
  AddBook(this.token);
  @override
  State<StatefulWidget> createState() {
    return AddBookState(token);
  }

}
class AddBookState extends State<AddBook>{
  String? token;
  AddBookState(this.token);
  late TextEditingController _nameController;
  late TextEditingController _authorController;
  late TextEditingController _urlController;

  late DioClient dioClient;

   File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedimg = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedimg != null) {
        _image = File(pickedimg.path);
      } else {
        _image = null;
        print('No Image Selected');
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = new TextEditingController();
    _authorController = new TextEditingController();
    _urlController= new TextEditingController();
    dioClient = DioClient();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(18, 93, 152, 1),
        title: Text("Add Book"),centerTitle: true,
      ),
      body:  Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(top: 40.0)),


            Container(
              child: Center(
                child:_image != null ? Image.file(_image!,height: 40.0,) : Image.asset("images/addbook.png",height: 40.0,)
                ,
              ),
            ),
            InkWell(
              onTap: () {
                 getImage();
                print("Clicked");
              },
              child: Text("Choose Image")
            ),
            Padding(padding: EdgeInsets.only(top: 40.0)),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Book Name",
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
              controller: _authorController,
              decoration: InputDecoration(
                hintText: "Author Name",
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
              controller: _urlController,
              decoration: InputDecoration(
                hintText: "Book URL",
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
                Future<Book> book =  dioClient.addBook(_image, _nameController.text, _authorController.text, _urlController.text, token);

               // Future<Book> book =  dioClient.addBook(token, _nameController.text, _authorController.text, _urlController.text);
                book.then((value) {

                 Navigator.of(context).push(
                     new MaterialPageRoute(
                         builder: (BuildContext context) =>
                         new AllBooks(token)));
               });

              },
              child: Text("Add Book"),
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
      );
  }


}