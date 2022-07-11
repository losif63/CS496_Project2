import 'dart:developer';

import 'package:cs496_project2_front_end/model/room_model.dart';
import 'package:cs496_project2_front_end/view/message_list_view.dart';
import 'package:cs496_project2_front_end/viewmodel/participate_viewmodel.dart';
import 'package:cs496_project2_front_end/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoomDetailView extends StatefulWidget {
  RoomModel roomToShow;

  RoomDetailView(this.roomToShow, {Key? key}) : super(key: key);

  @override
  State<RoomDetailView> createState() => _RoomDetailViewState();
}

class _RoomDetailViewState extends State<RoomDetailView> {
  String openerName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    foo() async {
      var currentUser = await fetchUserByUid(widget.roomToShow.opener);
      if (currentUser != null) {
        openerName = currentUser.name;
        log(openerName);
      }
    }

    foo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('모임 상세보기'), elevation: 0.0),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(10),
        child: ListView(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(widget.roomToShow.room_name,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)), //room_name
            Text('방 개설자: $openerName'), //room_opener
            Text('개설 날짜: ${widget.roomToShow.open_time}'), //room_opentime
            Text(
                '인원 수: 4/${widget.roomToShow.max_participants}'), // curparticipants/maxparticipants
            Text(widget.roomToShow.description), //room_description
          ]),
          //ListView.builder(physics: NeverScrollableScrollPhysics(), itemBuilder: (){}, itemCount: 0,) //가입자 리스트뷰
        ]),
      ),
      floatingActionButton: CustomActionButton(widget.roomToShow),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class CustomActionButton extends StatefulWidget {
  RoomModel room;
  CustomActionButton(this.room, {Key? key}) : super(key: key);

  @override
  State<CustomActionButton> createState() => _CustomActionButtonState();
}

class _CustomActionButtonState extends State<CustomActionButton> {
  String action = '가입하기';
  Icon actionIcon = const Icon(MdiIcons.accountMultiplePlus);

  checkAction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('u_id') ?? '0';
    await fetchParticipants(widget.room.r_id).then((value) {
      for (var users in value) {
        if (users.toString() == uid) {
          action = '채팅 가기';
          actionIcon = const Icon(MdiIcons.forum);
          return;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkAction().then((val) => setState((() {})));
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => MessageListView())));
      },
      label: Text(action),
      icon: actionIcon,
    );
  }
}
