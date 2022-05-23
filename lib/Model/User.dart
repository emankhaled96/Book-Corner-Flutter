class User{
   final String? id;
   final String? name , email , token;

   User({ required this.id,
   required this.name,
   required this.email,
   required this.token}
       );



  factory User.fromJson(Map<String , dynamic> json){
     return User(id : json['id'],
         name : json['name'],
         email : json['email'],
         token : json['token']);
   }

  Map<String , dynamic> toJson()=>{
     'id':id,
    'name' : name,
    'email' :email,
    'token': token
  } ;

   static List <User> listfromJson (List<dynamic> list){
    return List<User>.from(list.map((x) => User.fromJson(x)));
   }
}