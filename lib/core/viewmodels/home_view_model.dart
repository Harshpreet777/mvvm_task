import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_task_demo/core/enums/viewstate.dart';
import 'package:mvvm_task_demo/core/models/page_one_response_model.dart';
import 'package:mvvm_task_demo/core/repos/services.dart';
import 'package:mvvm_task_demo/core/viewmodels/base_model.dart';

class HomeViewModel extends BaseModel {
  var userData;
  UserListResponseModel? _homeResponseModel;
  UserListResponseModel? get userDetailsResponse => _homeResponseModel;
  ApiServices apiServices = ApiServices();
  List<UserListResponseModel> gotData = [];
  List<dynamic> datas = [];
  List<UserListResponseModel> data = [];

  set userDetailsResponse(UserListResponseModel? value) {
    _homeResponseModel = value;
    updateUI();
  }

  Future<List<UserListResponseModel>> getUserDetails(BuildContext context, int page) async {
    Response response = await apiServices.getData(page);
    state = ViewState.busy;
    try {
      state = ViewState.idle;
      userData = response.data;
      if (userData.containsKey('data')) {
        datas = userData['data'];
        gotData = datas.map((e) {
          return UserListResponseModel.fromJson(e);
        }).toList();
        data.addAll(gotData);
        return data;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode.toString().startsWith("5") == true) {
          state = ViewState.idle;
          log(e.response!.statusMessage.toString());
        }
      }
      e.response != null
          ? debugPrint(e.response!.data["message"].toString())
          : debugPrint(e.message.toString());
      state = ViewState.idle;
    } catch (e) {
      log('SomeThing went wrong1');
      state = ViewState.idle;
    }
    state = ViewState.idle;
    return data;
  }
}
