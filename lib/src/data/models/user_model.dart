class UserModel {
  final String id;
  final String name;

  UserModel({required this.id, required this.name});

  factory UserModel.fromJson(Map<String, dynamic> j) =>
      UserModel(id: j['id'], name: j['name']);
}
