class News{
  final String id;
  final String title;
  final String body;
  final String photo;
  final int id_category;
  
  News({required this.id, required this.title, required this.body, required this.photo, required this.id_category});

  factory News.fromJson(Map<String, dynamic> json) => News(
    id: json['id'], 
    title: json['title'], 
    body: json['body'],
    photo: json['photo'],
    id_category: json['id_category'],
    );
}