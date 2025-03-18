import 'package:dio/dio.dart';

class AuthService {
  final Dio dio = Dio();

  // Login function
  Future<Map<String, dynamic>?> loginUser(
      String username, String password) async {
    try {
      var response = await dio.post(
        'http://10.0.2.2:5000/Login',
        data: {
          "username": username,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        return response.data; // Return user data on successful login
      } else {
        return null;
      }
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }
}


class ProductService {
  final Dio dio = Dio();

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    try {
      var response = await dio.get('http://10.0.2.2:5000/Products');

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        return [];
      }
    } catch (e) {
      print("Fetch Products Error: $e");
      return [];
    }
  }
}
