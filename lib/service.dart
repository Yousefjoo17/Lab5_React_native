import 'package:dio/dio.dart';

class NewsService {
  final Dio dio = Dio();

  Future<List<Map<String, dynamic>>> getUserInfo() async {
    try {
      var response = await dio.get(
        'https://simpleback-75013-default-rtdb.firebaseio.com/users.json/',
      );

      if (response.data is List) {
        List<dynamic> jsonData = response.data;

        List<Map<String, dynamic>> users =
            jsonData.map((e) => e as Map<String, dynamic>).toList();

        print(users);
        return users;
      } else {
        throw Exception("Unexpected data format: Expected a List");
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
