import 'dart:developer';

import 'package:cs496_project2_front_end/model/participate_model.dart';
import 'package:cs496_project2_front_end/model/room_model.dart';
import 'package:cs496_project2_front_end/model/user_model.dart';
import 'package:cs496_project2_front_end/view/message_list_view.dart';
import 'package:cs496_project2_front_end/viewmodel/participate_viewmodel.dart';
import 'package:cs496_project2_front_end/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoomDetailView extends StatefulWidget {
  RoomModel roomToShow;

  RoomDetailView(this.roomToShow, {Key? key}) : super(key: key);

  @override
  State<RoomDetailView> createState() => _RoomDetailViewState();
}

class _RoomDetailViewState extends State<RoomDetailView> {
  String openerName = '';
  List<int> participantsUid = [];
  List<UserModel> participants = [];

  @override
  void initState() {
    super.initState();

    fetchParticipants(widget.roomToShow.r_id).then((value) {
      participantsUid = value;
      setState(() {});
    });

    fetchUserByUid(widget.roomToShow.opener).then((result) {
      setState(() {
        if (result != null) {
          openerName = result.name;
          log(openerName);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('모임 상세보기'), elevation: 0.0),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Text(widget.roomToShow.room_name,
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold)), //room_name
              const SizedBox(height: 5),
              Text(
                widget.roomToShow.description,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              ), //room_description
              const SizedBox(height: 5),
              Text('방 개설자: $openerName'), //room_opener
              const SizedBox(height: 5),
              Text('개설 날짜: ${widget.roomToShow.open_time}'), //room_opentime
              const SizedBox(height: 5),
              Text(
                  '인원 수: ${participantsUid.length}/${widget.roomToShow.max_participants}'), // curparticipants/maxparticipants
              const SizedBox(height: 10),
              const Divider(height: 1, color: Colors.black54),
              const SizedBox(height: 10),
              const Text(
                '가입자 목록',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 5),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: participantsUid.length,
                  itemBuilder: ((context, index) {
                    return FutureBuilder(
                        future: fetchUserByUid(participantsUid[index]),
                        builder: (context, AsyncSnapshot<UserModel?> snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              padding: EdgeInsets.all(5),
                              height: 60,
                              child: Row(children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      snapshot.data!.profile_pic == ''
                                          ? const AssetImage(
                                              'assets/images/avatar.png')
                                          : Image.network(
                                                  snapshot.data!.profile_pic)
                                              .image,
                                ),
                                const SizedBox(width: 5),
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: Text(
                                    '${snapshot.data!.name} (${snapshot.data!.email})',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                    maxLines: 2,
                                  ),
                                )
                              ]),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        });
                  })),
            ])),
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
  String uid = '';
  Icon actionIcon = const Icon(MdiIcons.accountMultiplePlus);

  checkAction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('u_id') ?? '0';
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
      onPressed: () async {
        if (action == '채팅 가기') {
          print('채팅!');
          Navigator.pop(context);
          pushNewScreen(context,
              screen: MessageListView(widget.room), withNavBar: false);
        } else {
          List<int> pars = await fetchParticipants(widget.room.r_id);
          if (pars.length == widget.room.max_participants) {
            print('가입 불가!');
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('최대 인원 수가 차 가입할 수 없습니다.'),
              behavior: SnackBarBehavior.floating,
              duration: Duration(milliseconds: 1000),
            ));
          } else {
            print('가입!');
            ParticipateModel newPar = ParticipateModel(
                p_id: 0,
                user: int.parse(uid),
                room: widget.room.r_id,
                join_time: DateTime.now().toIso8601String());
            await addParticipate(newPar);
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => RoomDetailView(widget.room))));
          }
        }
      },
      label: Text(action),
      icon: actionIcon,
    );
  }
}
