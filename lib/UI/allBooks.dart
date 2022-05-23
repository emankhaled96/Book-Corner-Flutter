import 'package:book_corner/Controller/dioclient.dart';
import 'package:book_corner/Controller/sessionManager.dart';
import 'package:book_corner/UI/addBook.dart';
import 'package:book_corner/UI/editBook.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/Book.dart';

class AllBooks extends StatefulWidget {
  String? token;
  AllBooks(this.token);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new AllBooksState(token);
  }
}

class AllBooksState extends State<AllBooks> {
  String? token;
  AllBooksState(this.token);

  late DioClient dioClient;
  late Future<Book> book;
  late Future<List<Book>> books;
  static const IMAGE_URL = "http://android.muhamadmahmoud.com/";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dioClient = DioClient();
    books = dioClient.getBooks(token);


    print("Books:$token");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(18, 93, 152, 1),
        title: Text("All Books"),
      ),
      body: widgetgetData(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(250, 200, 177, 1),
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () => addBook(context,token),
      ),
    );
  }

  Widget widgetgetData() {
    return FutureBuilder<List<Book>>(
        future: books,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List? data = snapshot.data;
            print("Data : ${snapshot.data[0].id}");

            // new Container();
            return ListView.builder(
              itemBuilder: (BuildContext context, int position) {
                print("${data![position].name}");
                return Column(
                  children: [
                    Divider(
                      height: 6.0,
                    ),
                    SizedBox(
                      height: 100,
                      child: Card(
                        color: Color.fromRGBO(18, 93, 152, 1),
                        child: Row(
                          children: [
                            new Expanded(
                                child: ListTile(
                              title: Text(
                                "${data[position].name}",
                                style: TextStyle(
                                    color: Color.fromRGBO(148, 218, 255, 1),
                                    fontSize: 22.0),
                              ),
                              subtitle: Text(
                                  "${data[position].author}" + "\n"
                                  // +"${data[position].created_at}"
                                  ,
                                  style: TextStyle(
                                      color: Color.fromRGBO(148, 218, 255, 1),
                                      fontSize: 20.0)),
                              leading: SizedBox(
                                  height: 130,
                                  width: 80,
                                  child: Image.network(
                                    IMAGE_URL + "${data[position].image}",
                                    height: 130,
                                    width: 80,
                                  )),
                            )),
                            IconButton(
                                onPressed: () => editBook(context,data[position],position,token),
                                icon: Icon(
                                  Icons.edit,
                                  color: Color.fromRGBO(250, 200, 177, 1),
                                  size: 30,
                                )),
                            IconButton(
                                onPressed: () => _showMyDialog(context, data[position], position),
                                icon: Icon(
                                  Icons.delete,
                                  color: Color.fromRGBO(250, 200, 177, 1),
                                  size: 30,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              itemCount: data!.length,
            );
          } else {
            return new Container();
          }
        });
  }

  void editBook(BuildContext context, Book book, int position , String? token) async{
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditBook(book,token)));
  }



  Future _showMyDialog(BuildContext context , Book book, int position)async{
    return showDialog(context: context, builder: (BuildContext context ){
      return AlertDialog(
        title: Text("Delete Book"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text("Do You Really Want To Delete This Book ?")
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: ()=>removeBook(context, book, position), child: Text("Yes")),
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text("No"))
        ],
      );
    });
  }
  void removeBook(BuildContext context, Book book, int position)async {

    await dioClient.remove(token, book.id).then((_) => {
          books.then((x) => {
                setState(() {
                  x.removeAt(position);
                  Navigator.of(context).pop();
                })
              })
        });
  }

  addBook(BuildContext context ,String? token)  async{
     await Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddBook(token)));
  }
}

// 3) keep logged in




// 1) Register---->Done
// 2) image (add---->Done & edit---> Done)

// 4) null url----> Done