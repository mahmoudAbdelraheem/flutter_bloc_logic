import 'package:dio/dio.dart';
import 'package:flutter_bloc_logic/constants/strings.dart';

class CharacterWebServices {
  late Dio dio;
  late Dio quoteDio;

  CharacterWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );
    dio = Dio(options);
    BaseOptions quoteOptions = BaseOptions(
      baseUrl: quoteUrl,
      headers: quoteApiKey,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );
    quoteDio = Dio(quoteOptions);
  }

  //get all characters data
  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get(getFirst15Characters);
      // print(response.data.toString());
      return response.data;
    } catch (e) {
      // print('Error in catch of get all character dio => ${e.toString()}');
      return []; // to return empty list;
    }
  }

  //get all characters data
  Future<List<dynamic>> getRandomQuote(String category) async {
    try {
      Response response =
          await quoteDio.get('quotes', queryParameters: {'category': category});
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print('Error in catch of get all character dio => ${e.toString()}');
      return []; // to return empty list;
    }
  }
}
