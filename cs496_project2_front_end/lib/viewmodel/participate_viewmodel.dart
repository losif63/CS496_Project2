import 'dart:convert';
import 'package:cs496_project2_front_end/model/participate_model.dart';
import 'package:http/http.dart' as http;

Future<List<ParticipateModel>> fetchParticipates() async {
  final response =
      await http.get(Uri.parse('http://192.249.18.152/participate/fetchall'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> participatorList = jsonDecode(response.body);
    List<ParticipateModel> participators = [];
    for (final participant in participatorList) {
      participators.add(ParticipateModel.fromJson(participant));
    }
    return participators;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Participants');
  }
}

Future<ParticipateModel> addParticipate(ParticipateModel participate) async {
  final response = await http.post(
      Uri.parse('http://192.249.18.152/participate/createparticipate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, dynamic>{
        'p_id': participate.p_id,
        'user': participate.user,
        'room': participate.room,
        'join_time': participate.join_time
      }));
  if (response.statusCode == 201) {
    return ParticipateModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to add room');
  }
}

List<int> fetchMyParticipates(int uid) {
  List<int> myParticipates = [];

  fetchParticipates().then((value) {
    for (var participate in value) {
      if (participate.user == uid) {
        myParticipates.add(participate.p_id);
      }
    }
  });

  return myParticipates;
}
