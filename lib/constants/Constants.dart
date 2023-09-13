import 'package:store/reference/references.dart';

enum VipLevel {
  normal,
  bronze,
  silver,
  golden,
}

final Dio dio = Dio();
String requestUrl = "http://localhost:8080";