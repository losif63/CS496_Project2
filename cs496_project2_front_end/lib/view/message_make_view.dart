import 'dart:developer';

import 'package:cs496_project2_front_end/viewmodel/message_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/message_model.dart';
import '../model/room_model.dart';
import 'message_list_view.dart';

class MessageMakeView extends StatefulWidget {
  MessageMakeView(this.room, {Key? key}) : super(key: key);
  RoomModel room;

  @override
  State<MessageMakeView> createState() => _MessageMakeViewState();
}

class _MessageMakeViewState extends State<MessageMakeView> {
  final _formKey = GlobalKey<FormState>();
  String content = '';
  String curTime = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('메세지 보내기'),
          elevation: 0.0,
        ),
        body: Container(
            margin: const EdgeInsets.all(10),
            child: Column(children: <Widget>[
              Form(
                  key: _formKey,
                  child: ListTile(
                    title: const Text("보낼 메세지"),
                    subtitle: TextFormField(
                      maxLines: 10,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: '메세지 내용',
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (val) {
                        if (val != null) {
                          if (val.length > 0) {
                            if (val.length < 201) {
                              return null;
                            }
                            return '메세지를 200자 이하로 적어주세요.';
                          }
                        }
                        return '메세지를 1자 이상 적어주세요.';
                      },
                      onSaved: (val) {
                        setState(() => {content = val!});
                        log('content: ${content}');
                      },
                    ),
                  )),
              const SizedBox(height: 10),
              Container(
                height: 75,
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: const Text(
                        '전송',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        // log('${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}');
                        MessageModel newMessage = MessageModel(
                            m_id: 0,
                            room: widget.room.r_id,
                            user: int.parse(prefs.getString('u_id') ?? '0'),
                            content: content,
                            send_time:
                                '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}');
                        addMessage(newMessage).then((value) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      MessageListView(widget.room))));
                        });
                      }
                      //Todo
                    }),
              )
            ])));
  }
}
