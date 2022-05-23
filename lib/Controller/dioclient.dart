
import 'dart:io';

import 'package:book_corner/Controller/sessionManager.dart';
import 'package:book_corner/Model/Book.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/User.dart';

class DioClient{
   Dio dio = Dio();


  static const baseURL = "http://android.muhamadmahmoud.com/api/";

  static const URL_REGISTER= baseURL + "register";
  static const URL_LOGIN = baseURL + "login";
  static const URL_GET_ALL_DATA= baseURL + "books";


Future<List<Book>> getBooks(String? token) async{
  try{

    final response = await dio.get(URL_GET_ALL_DATA,options: Options(headers: {
    "Accept" : "application/json",
    "Authorization":"Bearer " +token!
    }));
    print("Response = ${response.data['data']}");
    return Book.listfromJson(response.data['data']);
  }on DioError catch(e){
    print(e.message);
    throw Exception("Failed to get data");

  }
}
   // Future<Book> addBook(String? token,String name , String author , String url ) async{
   //   try{
   //
   //    print('URL : $url');
   //
   //     String defval= "null";
   //     if(url == ''){
   //       final response = await dio.post(URL_GET_ALL_DATA,options: Options(headers: {
   //         "Accept" : "application/json",
   //         "Authorization":"Bearer " +token!
   //       }),data: {
   //         "name": name,
   //         "author": author,
   //         // "image":imagepath,
   //         "url": defval,
   //       });
   //
   //       print("Response = ${response.data['data']}");
   //       return Book.fromJson(response.data['data']);
   //     }else{
   //       final response = await dio.post(URL_GET_ALL_DATA,options: Options(headers: {
   //         "Accept" : "application/json",
   //         "Authorization":"Bearer " +token!
   //       }),data: {
   //         "name": name,
   //         "author": author,
   //         // "image":imagepath,
   //         "url": url,
   //       });
   //
   //       print("Response = ${response.data['data']}");
   //       return Book.fromJson(response.data['data']);
   //     }
   //
   //   }on DioError catch(e){
   //     print(e.message);
   //     throw Exception("Failed to get data");
   //
   //   }
   // }
   //

  //  Future<Book> editBook(String? token,String name , String author , String url ,int? id,File? file) async{
  //
  // try{
  //
  //      String defval= "null";
  //      final response = await dio.post(URL_GET_ALL_DATA+"/"+id.toString(),options: Options(headers: {
  //        "Accept" : "application/json",
  //        "Authorization":"Bearer " +token!
  //      }),data: {
  //        "name": name,
  //        "author": author,
  //        // "image":imagepath,
  //        "url": url,
  //      });
  //
  //      print("Response = ${response.data['data']}");
  //      return Book.fromJson(response.data['data']);
  //    }on DioError catch(e){
  //      print(e.message);
  //      throw Exception("Failed to get data");
  //
  //    }
  //  }
   Future<Book> editBook(String? token,String name , String author , String url ,int? id,File? file) async {
     if (file == null){

       try{

         print('URL : $url');

         String defval= "null";
         if(url == ''){
           final response = await dio.post(URL_GET_ALL_DATA+"/"+id.toString(),options: Options(headers: {
             "Accept" : "application/json",
             "Authorization":"Bearer " +token!
           }),data: {
             "name": name,
             "author": author,
             // "image":imagepath,
             "url": defval,
           });

           print("Response = ${response.data['data']}");
           return Book.fromJson(response.data['data']);
         }else{
           final response = await dio.post(URL_GET_ALL_DATA+"/"+id.toString(),options: Options(headers: {
             "Accept" : "application/json",
             "Authorization":"Bearer " +token!
           }),data: {
             "name": name,
             "author": author,
             // "image":imagepath,
             "url": url,
           });

           print("Response = ${response.data['data']}");
           return Book.fromJson(response.data['data']);
         }

       }on DioError catch(e){
         print(e.message);
         throw Exception("Failed to get data");

       }

     }else{
       if(url ==''){

         String fileName = file.path.split('/').last;
         print("FileName  :$fileName");

         FormData formData = new FormData.fromMap({
           "name": name,
           "author": author,
           // "image":imagepath,
           "url": "null",
           "image": await MultipartFile.fromFile(file.path,filename: fileName),
         });

         final response = await dio
             .post(URL_GET_ALL_DATA+"/"+id.toString(),data:formData,options: Options(headers: {
           "Accept" : "application/json",
           "Authorization":"Bearer " +token!
         }));
         print("Response = ${response.data['data']}");
         return Book.fromJson(response.data['data']);
       }else{
         String fileName = file.path.split('/').last;
         print("FileName  :$fileName");

         FormData formData = new FormData.fromMap({
           "name": name,
           "author": author,
           // "image":imagepath,
           "url": url,
           "image": await MultipartFile.fromFile(file.path,filename: fileName),
         });

         final response = await dio
             .post(URL_GET_ALL_DATA+"/"+id.toString(),data:formData,options: Options(headers: {
           "Accept" : "application/json",
           "Authorization":"Bearer " +token!
         }));
         print("Response = ${response.data['data']}");
         return Book.fromJson(response.data['data']);
       }
     }
   }



















   Future<void> createUser(String name , String email ,String password )async{
   try{
     final response = await dio.post(URL_REGISTER,
         options: Options(contentType: "application/json"),
     data: {
       "name" : name,
       "email" : email,
       "password" : password,
       "c_password" : password
     });
     debugPrint(response.toString());
   }on DioError catch(e){


     debugPrint("Status code : ${e.message}");
     throw Exception("Failed To Create User");
   }
  }
   setPrefs(User user) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();

     prefs.setString("token", user.token.toString());
     print('USER HAS BE STORED TO SHAREDPREFERENCES');

   }

   Future<User> login(String email , String pass ,BuildContext context)async{
    try{
      final response = await dio.post(URL_LOGIN,
          options: Options(contentType: "application/json")
          ,data:
      {
        "Content-Type" : "application/json",
        "email":email,
        "password":pass
      });

      User user = new User.fromJson(response.data['success']);

      if (response.statusCode==200) {


        setPrefs(user);
      }
      print("Name ${user.name} , Email : ${user.email} , id ${user.id} ,token : ${user.token}");
      print("Response = ${response.data}");
      return user;

    }on DioError catch(e){
      print(e.response);
      throw Exception("Failed to get data");

    }
  }

   Future<void> remove(String? token , int? id) async{
     try{

       final response = await dio.delete(URL_GET_ALL_DATA+"/"+id.toString(),
           options: Options(headers: {
         "Accept" : "application/json",
         "Authorization":"Bearer " +token!
       }));
       print("Response = ${response}");
     }on DioError catch(e){
       print(e.message);
       throw Exception("Failed to get data");

     }
   }



   Future<Book> addBook(File? file ,String name , String author ,String url,String? token) async {
     if (file == null){

       try{

         print('URL : $url');

         String defval= "null";
         if(url == ''){
           final response = await dio.post(URL_GET_ALL_DATA,options: Options(headers: {
             "Accept" : "application/json",
             "Authorization":"Bearer " +token!
           }),data: {
             "name": name,
             "author": author,
             // "image":imagepath,
             "url": defval,
           });

           print("Response = ${response.data['data']}");
           return Book.fromJson(response.data['data']);
         }else{
           final response = await dio.post(URL_GET_ALL_DATA,options: Options(headers: {
             "Accept" : "application/json",
             "Authorization":"Bearer " +token!
           }),data: {
             "name": name,
             "author": author,
             // "image":imagepath,
             "url": url,
           });

           print("Response = ${response.data['data']}");
           return Book.fromJson(response.data['data']);
         }

       }on DioError catch(e){
         print(e.message);
         throw Exception("Failed to get data");

       }

     }else{
       if(url ==''){

         String fileName = file.path.split('/').last;
         print("FileName  :$fileName");

         FormData formData = new FormData.fromMap({
           "name": name,
           "author": author,
           // "image":imagepath,
           "url": "null",
           "image": await MultipartFile.fromFile(file.path,filename: fileName),
         });

         final response = await dio
             .post(URL_GET_ALL_DATA,data:formData,options: Options(headers: {
           "Accept" : "application/json",
           "Authorization":"Bearer " +token!
         }));
         print("Response = ${response.data['data']}");
         return Book.fromJson(response.data['data']);
       }else{
     String fileName = file.path.split('/').last;
     print("FileName  :$fileName");

     FormData formData = new FormData.fromMap({
       "name": name,
       "author": author,
       // "image":imagepath,
       "url": url,
       "image": await MultipartFile.fromFile(file.path,filename: fileName),
     });

     final response = await dio
         .post(URL_GET_ALL_DATA,data:formData,options: Options(headers: {
       "Accept" : "application/json",
       "Authorization":"Bearer " +token!
     }));
     print("Response = ${response.data['data']}");
     return Book.fromJson(response.data['data']);
   }
     }
}

}