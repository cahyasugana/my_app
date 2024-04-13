import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_app/dto/news.dart';
import 'package:my_app/endpoints/endpoints.dart';

class DataService {
  //API Method
  //Show All
  static Future<List<News>> fetchNews() async {
    final response = await http.get(Uri.parse(Endpoints.news));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((item) => News.fromJson(item)).toList();
    } else {
      // Handle error
      throw Exception('Failed to load news');
    }
  }

  //Show by ID
  static Future<News> fetchNewsById(String id) async {
    final response = await http.get(Uri.parse(
        'https://66038e2c2393662c31cf2e7d.mockapi.io/api/v1/news/$id'));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return News.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load book');
    }
  }

  // post data to endpoint news GAPAKE FOTO
  // static Future<News> createNews(String title, String body) async {
  //   final response = await http.post(
  //     Uri.parse(Endpoints.news),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'title': title,
  //       'body': body,
  //     }),
  //   );

  //   if (response.statusCode == 201) {
  //     // Check for creation success (201 Created)
  //     final jsonResponse = jsonDecode(response.body);
  //     return News.fromJson(jsonResponse);
  //   } else {
  //     // Handle error
  //     throw Exception('Failed to create post: ${response.statusCode}');
  //   }
  // }

  //test foto
  static Future<News> createNews(String title, String body,
      {String photo = 'https://loremflickr.com/640/480'}) async {
    final Map<String, dynamic> requestBody = {
      'title': title,
      'body': body,
    };

    // Only add photo to requestBody if it's not an empty string
    if (photo.isNotEmpty) {
      requestBody['photo'] = photo;
    }

    final response = await http.post(
      Uri.parse(Endpoints.news),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 201) {
      // Check for creation success (201 Created)
      final jsonResponse = jsonDecode(response.body);
      return News.fromJson(jsonResponse);
    } else {
      // Handle error
      throw Exception('Failed to create post: ${response.statusCode}');
    }
  }

  //UPDATE BERITA
  // Update news by ID
  static Future<News> updateNews(String id, String title, String body) async {
    final response = await http.put(
      Uri.parse('https://66038e2c2393662c31cf2e7d.mockapi.io/api/v1/news/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'body': body,
      }),
    );

    if (response.statusCode == 200) {
      // Check for success (200 OK)
      final jsonResponse = jsonDecode(response.body);
      return News.fromJson(jsonResponse);
    } else {
      // Handle error
      throw Exception('Failed to update news: ${response.statusCode}');
    }
  }

  //DELETE DATA BY ID
  static Future<void> deleteNewsById(String id) async {
    final response = await http.delete(Uri.parse(
        'https://66038e2c2393662c31cf2e7d.mockapi.io/api/v1/news/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete news');
    }
  }
}
