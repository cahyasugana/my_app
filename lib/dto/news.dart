class News {
  final String id;
  final String title;
  final String body;
  final String photo;
  final int id_category;

  News(
      {required this.id,
      required this.title,
      required this.body,
      required this.photo,
      required this.id_category});

  factory News.fromJson(Map<String, dynamic> json) => News(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        photo: json['photo'],
        id_category: json['id_category'],
      );
}

class Datas {
  final int idDatas;
  final String name;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Datas({
    required this.idDatas,
    required this.name,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Datas.fromJson(Map<String, dynamic> json) {
    return Datas(
      idDatas: json['id_datas'] as int,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'] as String)
          : null,
    );
  }
}