import 'package:cs496_project2_front_end/model/room_model.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RoomDetailView extends StatefulWidget {
  RoomModel roomId;

  RoomDetailView(this.roomId, {Key? key}) : super(key: key);

  @override
  State<RoomDetailView> createState() => _RoomDetailViewState();
}

class _RoomDetailViewState extends State<RoomDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('모임 상세보기'), elevation: 0.0),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(10),
        child: ListView(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Text('새벽 4시까지 즐겁게 같이 밤샐 사람들을 구합니다',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)), //room_name
            Text('개발자123'), //room_opener
            Text('22/07/07 22:24'), //room_opentime
            Text('4/10'), // curparticipants/maxparticipants
            Text('이 방은 서버 때무네 죽을 것 같은 2분반만이 가입할 수 있슴니다.'), //room_description
          ]),
          //ListView.builder(physics: NeverScrollableScrollPhysics(), itemBuilder: (){}, itemCount: 0,) //가입자 리스트뷰
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('가입하기'),
        icon: const Icon(MdiIcons.accountMultiplePlus),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
