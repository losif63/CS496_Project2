import 'package:cs496_project2_front_end/model/room_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<RoomModel>> fetchRooms() async {
  final response =
      await http.get(Uri.parse('http://192.249.18.152/fetchrooms'));

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
