import 'dart:convert';
import 'package:cs496_project2_front_end/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';

Future<List<UserModel>> fetchUsers() async {
  final response =
      await http.get(Uri.parse('http://192.249.18.152/user/fetchall'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> userList = jsonDecode(response.body);
    List<UserModel> users = [];
    for (final user in userList) {
      users.add(UserModel.fromJson(user));
    }
    return users;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Users');
  }
}

Future<UserModel> addUser(UserModel user) async {
  final response = await http.post(
      Uri.parse('http://192.249.18.152/user/createuser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, dynamic>{
        'u_id': user.u_id,
        'name': user.name,
        'profile_word': user.profile_word,
        'profile_pic': user.profile_pic,
        'email': user.email,
        'password': user.password,
        'birthdate': user.birthdate
      }));
  if (response.statusCode == 201) {
    return UserModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to add user');
  }
}

Future<UserModel?> fetchUserByEmail(String userEmail) async {
  List<UserModel> users = await fetchUsers();

  for (var user in users) {
    if (user.email == userEmail) return user;
  }
  return null;
}

Future<UserModel?> fetchUserByUid(int uid) async {
  List<UserModel> users = await fetchUsers();

  for (var user in users) {
    if (user.u_id == uid) return user;
  }
  return null;
}

Future<UserModel> updateUser(UserModel user) async {
  final response = await http.put(
      Uri.parse('http://192.249.18.152/user/updateuser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, dynamic>{
        'u_id': user.u_id,
        'name': user.name,
        'profile_word': user.profile_word,
        'profile_pic': user.profile_pic,
        'email': user.email,
        'password': user.password,
        'birthdate': user.birthdate
      }));
  if (response.statusCode == 200) {
    return UserModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update user');
  }
}
