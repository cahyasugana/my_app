import 'package:flutter/material.dart';

class Note {
  late int? id;
  late String title;
  late String child;
  Note(this.id, this.title, this.child);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'title': title,
      'child' : child,
    };
    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    child = map['child'];
  }
}

//TEST CLASS
class MenuItem {
  final ImageProvider<Object> image;
  final String title;
  final String description;
  final int price; // Changed type to int

  MenuItem({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
  });
}