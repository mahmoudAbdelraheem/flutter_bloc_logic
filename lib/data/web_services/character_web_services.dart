import 'package:dio/dio.dart';
import 'package:flutter_bloc_logic/constants/strings.dart';

class CharacterWebServices {
  late Dio dio;

  CharacterWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );
    dio = Dio(options);
  }

  //get all characters data
  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get(getFirst10Characters);
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print('Error in catch of get all character dio => ${e.toString()}');
      return []; // to return empty list;
    }
  }
}
