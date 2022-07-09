import 'dart:convert';
import 'package:cs496_project2_front_end/model/message_model.dart';
import 'package:http/http.dart' as http;

Future<List<MessageModel>> fetchMessages() async {
  final response =
      await http.get(Uri.parse('http://192.249.18.152/fetchmessages'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> messageList = jsonDecode(response.body);
    List<MessageModel> messages = [];
    for (final message in messageList) {
      messages.add(MessageModel.fromJson(message));
    }
    return messages;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Messages');
  }
}
