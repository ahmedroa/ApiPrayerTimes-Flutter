import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static inIt() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://api.aladhan.com/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }
}
