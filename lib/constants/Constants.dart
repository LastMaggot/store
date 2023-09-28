import 'package:store/comphonents/DioInterceptor.dart';
import 'package:store/reference/references.dart';

enum VipLevel {
  normal,
  bronze,
  silver,
  golden,
}

String requestUrl = "http://localhost:8080";
final Dio dio = Dio(BaseOptions(
  connectTimeout: Duration(seconds: 20),
  receiveTimeout: Duration(seconds: 20),
  baseUrl: requestUrl,
))..interceptors.add(DioInterceptor());
