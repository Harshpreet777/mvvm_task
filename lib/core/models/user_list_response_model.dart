// To parse this JSON data, do
//
//     final Page1ResponseModel = Page1ResponseModelFromJson(jsonString);

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'page_one_response_model.g.dart';

List<Page1ResponseModel> responseModelFromJson(String str) =>
    List<Page1ResponseModel>.from(
        json.decode(str).map((x) => Page1ResponseModel.fromJson(x)));

String responseModelToJson(Page1ResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class Page1ResponseModel {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<UserListResponseModel> data;
  Support support;

  Page1ResponseModel({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support,
  });

  factory Page1ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$Page1ResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$Page1ResponseModelToJson(this);
}
@JsonSerializable()
class UserListResponseModel {
  int id;
  String email;
  @JsonKey(name: "first_name")
  String firstName;
  @JsonKey(name:"last_name")
  String lastName;
  String avatar;

  UserListResponseModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory UserListResponseModel.fromJson(Map<String, dynamic> json) => _$UserListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserListResponseModelToJson(this);
}

@JsonSerializable()
class Support {
  String url;
  String text;

  Support({
    required this.url,
    required this.text,
  });

  factory Support.fromJson(Map<String, dynamic> json) =>
      _$SupportFromJson(json);

  Map<String, dynamic> toJson() => _$SupportToJson(this);
}
