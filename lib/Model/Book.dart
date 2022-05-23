class Book{
  final int? id;
  final String? name , author , created_at , updated_at ,url,image;

  Book({ required this.id,
    required this.name,
    required this.author,
    required this.created_at,
  required this.updated_at,
  required this.url,
  required this.image}
      );


  factory Book.fromJson(Map<String , dynamic> json){
    return Book(
        id : json['id'],
        name : json['name'],
        author : json['author'],
        created_at : json['created_at'],
        updated_at : json['updated_at'],
        url : json['url'],
        image : json['image']
    );
  }

  Map<String , dynamic> toJson()=>{
    'id':id,
    'name' : name,
    'author' :author,
    'created_at': created_at,
    'updated_at': updated_at,
    'url': url,
    'image': image,

  } ;

  static List <Book> listfromJson (List<dynamic> list){
    return List<Book>.from(list.map((x) => Book.fromJson(x)));
  }
}