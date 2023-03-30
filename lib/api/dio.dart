import 'package:dio/dio.dart';

class DioApi {
  final dio = Dio();
  final apiPath = 'https://jsonplaceholder.typicode.com';

  Future<List<dynamic>> request() async {
    Response response;
    response = await dio.get('${apiPath}/posts');
    return response.data as List;
  }
}
