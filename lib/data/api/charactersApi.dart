import 'package:breaking_bad/helper/constans.dart';
import 'package:dio/dio.dart';

class CharacterApi {
  late Dio dio;
  CharacterApi() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      // receiveTimeout: 20 * 1000, // 20 sec.
      // connectTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharactersFromServer() async {
    try {
      Response response = await dio.get('characters'); // = baseUrl+"characters"
      return response.data;
    } catch (e) {
      return [];
    }
  }
}
