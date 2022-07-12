import 'dart:convert';
import 'package:cs496_project2_front_end/model/participate_model.dart';
import 'package:cs496_project2_front_end/model/room_model.dart';
import 'package:cs496_project2_front_end/viewmodel/room_viewmodel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

Future<List<int>> fetchMyParticipates(int uid) async {
  List<int> myParticipates = [];

  await fetchParticipates().then((value) {
    for (var participate in value) {
      if (participate.user == uid) {
        myParticipates.add(participate.room);
      }
    }
  });

  return myParticipates;
}

Future<List<int>> fetchParticipants(int rid) async {
  List<int> participantsUid = [];

  await fetchParticipates().then((value) {
    for (var participate in value) {
      if (participate.room == rid) {
        participantsUid.add(participate.user);
      }
    }
  });
  return participantsUid;
}

Future<http.Response> deleteParticipate(int pid) async {
  print('pid: ' + pid.toString());
  final response = await http.delete(
      Uri.parse('http://192.249.18.152/participate/deleteparticipate/$pid'),
      headers: <String, String>{'Content-Type': 'text/plain'});
  if (response.statusCode == 203) {
    return response;
  } else {
    throw Exception('Failed to delete participate');
  }
}

exitRoom(int rid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = prefs.getString('u_id') ?? '0';
  ParticipateModel participateToDelete =
      ParticipateModel(p_id: 0, user: 0, room: 0, join_time: '');
  await fetchParticipates().then((value) {
    for (var par in value) {
      if (par.room == rid && par.user == int.parse(uid)) {
        participateToDelete = par;
        break;
      }
    }
  });
  await fetchParticipants(participateToDelete.room).then((value) {
    if (value.length == 1) {
      //참여자==나 하나 -> 방 삭제
      deleteRoom(participateToDelete.room);
    }
  });
  await deleteParticipate(participateToDelete.p_id);
  return;
}
