import 'package:cs496_project2_front_end/model/room_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<RoomModel>> fetchRooms() async {
  final response =
      await http.get(Uri.parse('http://192.249.18.152/room/fetchall'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> roomList = jsonDecode(response.body);
    List<RoomModel> rooms = [];
    for (final room in roomList) {
      rooms.add(RoomModel.fromJson(room));
    }
    return rooms;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Rooms');
  }
}

Future<RoomModel> addRoom(RoomModel room) async {
  final response = await http.post(
      Uri.parse('http://192.249.18.152/room/createroom'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, dynamic>{
        'r_id': room.r_id,
        'room_name': room.room_name,
        'description': room.description,
        'opener': room.opener,
        'open_time': room.open_time,
        'max_participants': room.max_participants
      }));
  if (response.statusCode == 201) {
    return RoomModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to add room');
  }
}

Future<http.Response> deleteRoom(int rid) async {
  final response = await http.delete(
      Uri.parse('http://192.249.18.152/room/deleteroom?$rid'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });
  if (response.statusCode == 203) {
    return response;
  } else {
    throw Exception('Failed to delete user');
  }
}
