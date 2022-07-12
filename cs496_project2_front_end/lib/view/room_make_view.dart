import 'package:cs496_project2_front_end/model/participate_model.dart';
import 'package:cs496_project2_front_end/model/room_model.dart';
import 'package:cs496_project2_front_end/view/control_view.dart';
import 'package:cs496_project2_front_end/viewmodel/participate_viewmodel.dart';
import 'package:cs496_project2_front_end/viewmodel/room_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoomMakeView extends StatefulWidget {
  const RoomMakeView({Key? key}) : super(key: key);
  @override
  State<RoomMakeView> createState() => _RoomMakeViewState();
}

class _RoomMakeViewState extends State<RoomMakeView> {
  final _formKey = GlobalKey<FormState>();

  String roomName = '';

  String roomDescription = '';

  int maximumParticipants = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('방 추가하기'),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(children: <Widget>[
              Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          title: const Text("방 이름"),
                          subtitle: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              hintText: '방 이름을 적어주세요.',
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (val) {
                              if (val != null) {
                                if (val.length > 1) {
                                  if (val.length < 31) {
                                    return null;
                                  }
                                  return '방 제목을 30자 이하로 지어주세요.';
                                }
                              }
                              return '방 제목을 2자 이상으로 지어주세요.';
                            },
                            onSaved: (val) => setState(() => roomName = val!),
                          ),
                        ),
                        ListTile(
                          title: const Text("방 설명"),
                          subtitle: TextFormField(
                            maxLines: 5,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              hintText: '방에 대한 설명을 적어주세요.',
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (val) {
                              if (val != null) {
                                if (val.length > 9) {
                                  if (val.length < 101) {
                                    return null;
                                  }
                                  return '방 설명을 200자 이하로 적어주세요.';
                                }
                              }
                              return '방 설명을 최소 10자 이상으로 적어주세요.';
                            },
                            onSaved: (val) =>
                                setState(() => roomDescription = val!),
                          ),
                        ),
                        ListTile(
                          title: const Text("최대 인원 수"),
                          subtitle: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              hintText: '최대 인원 수를 숫자로 적어주세요.',
                            ),
                            keyboardType: TextInputType.number,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (val) {
                              if (val != null) {
                                if (val.isNotEmpty) {
                                  if (int.tryParse(val) != null) {
                                    if (int.parse(val) > 1) {
                                      return null;
                                    }
                                    return '2 이상의 숫자를 입력해주세요.';
                                  }
                                  return '숫자만 이용해서 적어주세요. eg) 7명 -> 7';
                                }
                              }
                              return '인원 수를 적어주세요.';
                            },
                            onSaved: (val) => setState(
                                () => maximumParticipants = int.parse(val!)),
                          ),
                        ),
                        Container(
                          height: 75,
                          padding: const EdgeInsets.all(16),
                          child: ElevatedButton(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                child: const Text(
                                  '방 만들기',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  RoomModel newRoom = RoomModel(
                                      r_id: 0,
                                      room_name: roomName,
                                      description: roomDescription,
                                      opener: int.parse(
                                          prefs.getString('u_id') ?? '0'),
                                      open_time:
                                          DateTime.now().toIso8601String(),
                                      max_participants: maximumParticipants);
                                  addRoom(newRoom).then((value) {
                                    ParticipateModel newParticipate =
                                        ParticipateModel(
                                            p_id: 0,
                                            user: int.parse(
                                                prefs.getString('u_id') ?? '0'),
                                            room: value.r_id,
                                            join_time: DateTime.now()
                                                .toIso8601String());
                                    addParticipate(newParticipate);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                const ControlView())));
                                  });
                                }
                                //Todo
                              }),
                        )
                      ]))
            ])),
      ),
    );
  }
}
