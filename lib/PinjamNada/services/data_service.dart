import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/PinjamNada/dto/Instrument.dart';
import 'package:my_app/PinjamNada/dto/user.dart';
import 'dart:convert';
import 'package:my_app/dto/news.dart';
import 'package:my_app/dto/dto_uts.dart';
import 'package:my_app/PinjamNada/dto/myLoans.dart';
import 'package:my_app/PinjamNada/dto/loanRequest.dart';
import 'package:my_app/PinjamNada/endpoints/endpoints.dart';
import 'package:my_app/utils/constants.dart';
import 'package:my_app/utils/secure_storage_util.dart';

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

  // static Future<List<SiMobileAPI>> fetchAPI() async {
  //   final response = await http.get(Uri.parse(Endpoints.siAPI));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> jsonResponse = jsonDecode(response.body);
  //     return jsonResponse.map((item) => SiMobileAPI.fromJson(item)).toList();
  //   } else {
  //     // Handle error
  //     throw Exception('Failed to load news');
  //   }
  // }

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

  //Datas CRUD
  static Future<List<Datas>> fetchDatas() async {
    final response = await http.get(Uri.parse(Endpoints.datas));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => Datas.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data');
    }
  }

  static Future<void> deleteDatas(int id) async {
    final url = Uri.parse('${Endpoints.datas}/$id');
    final response = await http.delete(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete data');
    }
  }

  //UTS CRUD
  //READ
  static Future<List<CustomerService>> fetchAllCustomerService() async {
    final response =
        await http.get(Uri.parse(Endpoints.customerServiceWithNIM));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => CustomerService.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data');
    }
  }

  //CREATE

  static Future<void> deleteCustomerService(
    int idCustomerService,
  ) async {
    final url =
        '${Endpoints.customerServiceWithNIM}/$idCustomerService'; // URL untuk menghapus data dengan ID tertentu

    final response = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete Data');
    }
  }

  //PINJAM NADA
  //Authorization
  static Future<http.Response> sendLoginData(
      String username, String password) async {
    final url = Uri.parse(Endpoints.login);
    final data = {'username': username, 'password': password};

    final response = await http.post(
      url,
      body: data,
    );
    return response;
  }

  static Future<http.Response?> getUserInfo(String accessToken) async {
    try {
      final Uri url = Uri.parse(Endpoints.decodeToken);
      final Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken'
      };

      final http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        return response;
      } else {
        // Handle error conditions (e.g., invalid access token, unauthorized access)
        print(
            'Failed to retrieve user information. Status code: ${response.statusCode}');
        return null;
      }
    } on http.ClientException catch (e) {
      // Handle specific HTTP client errors
      print('Client error: $e');
      return null;
    } catch (e) {
      // Handle other errors (e.g., network issues, unexpected exceptions)
      print('Error fetching user information: $e');
      return null;
    }
  }

  static Future<http.Response> updateUser(
    int userID,
    String? email,
    String? full_name,
    String? phone,
  ) async {
    final body = jsonEncode({
      'email': email,
      'full_name': full_name,
      'phone': phone,
    });
    final headers = {"Content-Type": "application/json"};

    final response = await http.post(
        Uri.parse('${Endpoints.updateProfile}/$userID'),
        headers: headers,
        body: body);
    return response;
  }

  static Future<http.Response> getUserAdditionalInfo(int userID) async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:5000/api/v1/profile/read/$userID'));
    return response;
  }

  // static Future<http.Response> logoutData() async {
  //   final url = Uri.parse(Endpoints.logout);
  //   final String? accessToken =
  //       await SecureStorageUtil.storage.read(key: tokenStoreName);
  //   debugPrint("logout with $accessToken");

  //   final response = await http.post(url, headers: {
  //     'Context-Type': 'application/json',
  //     'Authorization': 'Bearer $accessToken',
  //   });
  //   return response;
  // }

  //INSTRUMENNTS RELATED
  static Future<List<Instruments>?> fetchAllAvailableInstruments() async {
    final response =
        await http.get(Uri.parse(Endpoints.fetchAllAvailableInstruments));
    debugPrint('${response.statusCode}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      // debugPrint(data['instruments'][0]['description']);
      return (data['instruments'] as List<dynamic>)
          .map((item) => Instruments.fromJson(item))
          .toList();
    } else {
      debugPrint('Failed to load data');
      return null;
    }
  }

  static Future<List<Instruments>?> fetchExcludingUser(int userId) async {
    final String url =
        '${Endpoints.fetchAllAvailableInstruments}/$userId'; // Assuming the endpoint structure

    final response = await http.get(Uri.parse(url));
    debugPrint('${response.statusCode}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      // debugPrint(data['instruments'][0]['description']);
      return (data['instruments'] as List<dynamic>)
          .map((item) => Instruments.fromJson(item))
          .toList();
    } else {
      debugPrint('Failed to load instruments');
      return null;
    }
  }

  static Future<List<Instruments>?> fetchInstrumentsByID(int userId) async {
    final String url =
        '${Endpoints.fetchInstrumentsByID}/$userId'; // Assuming the endpoint structure

    final response = await http.get(Uri.parse(url));
    debugPrint('${response.statusCode}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      // debugPrint(data['instruments'][0]['description']);
      return (data['instruments'] as List<dynamic>)
          .map((item) => Instruments.fromJson(item))
          .toList();
    } else {
      debugPrint('Failed to load instruments');
      return null;
    }
  }

  // LOAN RELATED
  // Fungsi untuk mengambil data dari API berdasarkan ID instrument
  Future<List<RequestLoan>> fetchRequestListById(int instrumentId) async {
    final response = await http.get(
      Uri.parse(
          '${Endpoints.fetchRequestLoan}/$instrumentId'), // Menggunakan query parameter ?id=
    );

    if (response.statusCode == 200) {
      // Jika request berhasil, parse data JSON dan buat list dari instrumen
      List<dynamic> data = jsonDecode(response.body)['list'];
      print(data);
      List<RequestLoan> listRequest =
          data.map((json) => RequestLoan.fromJson(json)).toList();
      return listRequest;
    } else {
      // Jika request gagal, lemparkan exception atau handle error sesuai kebutuhan aplikasi
      throw Exception('Failed to load instruments');
    }
  }

// MY Loans
  Future<List<MyLoans>?> fetchMyLoans(int userId) async {
    final response = await http.get(
      Uri.parse(
          '${Endpoints.myLoan}/$userId'), // Menggunakan query parameter ?id=
    );

    if (response.statusCode == 200) {
      // Jika request berhasil, parse data JSON dan buat list dari instrumen
      List<dynamic> data = jsonDecode(response.body)['list'];
      print(data);
      List<MyLoans> listRequest =
          data.map((json) => MyLoans.fromJson(json)).toList();
      return listRequest;
    } else {
      // Jika request gagal, lemparkan exception atau handle error sesuai kebutuhan aplikasi
      debugPrint('Failed to load instruments');
      return null;
    }
  }

  static Future<List<Instruments>?> fetchLoans(int userId) async {
    final response = await http.get(
      Uri.parse(
          '${Endpoints.loan}/$userId'), // Menggunakan query parameter ?id=
    );
    if (response.statusCode == 200) {
      // Jika request berhasil, parse data JSON dan buat list dari instrumen
      List<dynamic> data = jsonDecode(response.body)['instruments'];
      print(data);
      List<Instruments> listRequest =
          data.map((json) => Instruments.fromJson(json)).toList();
      return listRequest;
    } else {
      // Jika request gagal, lemparkan exception atau handle error sesuai kebutuhan aplikasi
      debugPrint('Failed to load instruments');
    }
  }

   Future<void> cancelLoanRequest(int requesterId, int requestId) async {
    final url = '${Endpoints.pinjamNadaBase}/api/v1/loan/cancel_loan_request/$requesterId/$requestId';
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Failed to cancel loan request');
      }
    } catch (e) {
      throw Exception('Failed to cancel loan request: $e');
    }
  }
}
