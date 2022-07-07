import 'package:flutter/material.dart';

class RoomDetailView extends StatelessWidget {
  const RoomDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('모임 상세보기'), elevation: 0.0),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('새벽 4시까지 즐겁게 같이 밤샐 사람들을 구합니다',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold)), //room_name
          const Text('개발자123'), //room_opener
          const Text('22/07/07 22:24'), //room_opentime
          const Text('4/10'), // curparticipants/maxparticipants
          const Text(
              '이 방은 서버 때무네 죽을 것 같은 2분반만이 가입할 수 있슴니다.'), //room_description
          const Expanded(child: SizedBox.shrink()),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(45)),
              onPressed: () {},
              child: const Text('가입하기',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)))
        ]),
      ),
    );
  }
}
