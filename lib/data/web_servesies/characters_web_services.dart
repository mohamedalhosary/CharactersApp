import 'package:flutter_breaking/core/constants/strings.dart';
import 'package:dio/dio.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      final response = await dio.get('character');
      return response.data['results']; // تعديل مهم هنا
    } catch (e) {
      print("Error fetching characters: $e");
      return [];
    }
  }
}
