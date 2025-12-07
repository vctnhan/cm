import 'package:json_annotation/json_annotation.dart';
part 'user_request_model.g.dart';

@JsonSerializable()
class UserRequestModel {
  final String id;
  final String name;

  UserRequestModel({required this.id, required this.name});
  factory UserRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UserRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserRequestModelToJson(this);
}
