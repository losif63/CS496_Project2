import 'package:flutter/material.dart';

class RoomChatView extends StatelessWidget {
  const RoomChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('모임 채팅'),
        elevation: 0.0,
      ),
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
          ChatWriteBar(),
        ]),
      ),
    );
  }
}

class ChatWriteBar extends StatefulWidget {
  const ChatWriteBar({Key? key}) : super(key: key);

  @override
  State<ChatWriteBar> createState() => _ChatWriteBarState();
}

class _ChatWriteBarState extends State<ChatWriteBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Row(children: [
        Flexible(
            fit: FlexFit.tight,
            child: TextField(
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  hintStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: '채팅을 입력해주세요',
                ))),
        AspectRatio(
            aspectRatio: 1,
            child: Container(
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(0)),
                      elevation: MaterialStateProperty.all(0)),
                  child: const Icon(Icons.send, size: 20)),
            )),
      ]),
    );
  }
}
