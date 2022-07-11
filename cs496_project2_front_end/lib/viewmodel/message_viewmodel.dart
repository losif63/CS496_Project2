import 'dart:convert';
import 'package:cs496_project2_front_end/model/message_model.dart';
import 'package:http/http.dart' as http;

Future<List<MessageModel>> fetchMessages() async {
  final response =
      await http.get(Uri.parse('http://192.249.18.152/message/fetchall'));

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

Future<MessageModel> addMessage(MessageModel message) async {
  final response = await http.post(
      Uri.parse('http://192.249.18.152/message/createmessage'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, dynamic>{
        'm_id': message.m_id,
        'room': message.room,
        'user': message.user,
        'content': message.content,
        'send_time': message.send_time
      }));
  if (response.statusCode == 201) {
    return MessageModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to add room');
  }
}

Future<List<MessageModel>> fetchMessagesByRid(int rid) async {
  List<MessageModel> roomMessages = [];

  await fetchMessages().then((result) {
    for (var msg in result) {
      if (msg.room == rid) roomMessages.add(msg);
    }
  });
  return roomMessages;
}
