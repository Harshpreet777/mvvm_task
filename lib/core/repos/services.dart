import 'dart:developer';

import 'package:dio/dio.dart';

class ApiServices {
  Future getData(int page) async {
    var dio = Dio();
    Response response;
    try {
      response = await dio.get('https://reqres.in/api/users?page=$page',
          options: Options(
            headers: {
              "Content-Type": "application/json",
            },
          ));

      return response;
    } catch (e) {
      log('Error sending request!');
    }
  }
}
