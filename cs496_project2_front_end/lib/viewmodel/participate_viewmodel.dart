import 'dart:convert';
import 'package:cs496_project2_front_end/model/participate_model.dart';
import 'package:http/http.dart' as http;

Future<List<ParticipateModel>> fetchParticipates() async {
  final response =
      await http.get(Uri.parse('http://192.249.18.152/fetchparticipates'));

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
