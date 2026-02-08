import 'package:dio/dio.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://api.escuelajs.co/api/v1/",
      receiveTimeout: Duration(seconds: 10),
      connectTimeout: Duration(seconds: 10),
    ),
  );

  static final Dio catDio = Dio(
    BaseOptions(
      baseUrl: "https://api.thecatapi.com/v1/images",
      receiveTimeout: Duration(seconds: 10),
      connectTimeout: Duration(seconds: 10),
    ),
  );
}
