import 'dart:developer';

import 'package:cs496_project2_front_end/model/message_model.dart';
import 'package:cs496_project2_front_end/model/room_model.dart';
import 'package:cs496_project2_front_end/model/user_model.dart';
import 'package:cs496_project2_front_end/viewmodel/message_viewmodel.dart';
import 'package:cs496_project2_front_end/viewmodel/participate_viewmodel.dart';
import 'package:cs496_project2_front_end/viewmodel/user_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'message_make_view.dart';

class MessageListView extends StatelessWidget {
  MessageListView(this.room, {Key? key}) : super(key: key);
  RoomModel room;

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = ScrollController();
    return Builder(
      builder: (context) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('메세지 목록'),
              elevation: 0.0,
              actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: (value) async {
                    switch (value) {
                      case '탈퇴하기':
                        await exitRoom(room.r_id);
                        Navigator.pop(context);
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return {'탈퇴하기'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
            body: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: FutureBuilder<List<MessageModel>>(
                  future: fetchMessagesByRid(room.r_id),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData &&
                        snapshot.data!.isNotEmpty) {
                      return Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.separated(
                              controller: _controller,
                              scrollDirection: Axis.vertical,
                              itemBuilder: ((context, index) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(3.0)),
                                    child: Row(
                                      children: [
                                        Profile(snapshot.data![index].user),
                                        const SizedBox(width: 15),
                                        Text(snapshot.data![index].content,
                                            style:
                                                const TextStyle(fontSize: 16)),
                                        const Expanded(child: SizedBox()),
                                        Column(
                                          children: [
                                            Text(
                                              snapshot.data![index].send_time
                                                  .substring(0, 10),
                                              style: TextStyle(fontSize: 11.5),
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              snapshot.data![index].send_time
                                                  .substring(10),
                                              style: TextStyle(fontSize: 11.5),
                                            )
                                          ],
                                        )
                                      ],
                                    ));
                              }),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 10),
                              itemCount: snapshot.data!.length));
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
                )),
            floatingActionButton: Row(
              children: [
                SizedBox(width: 30),
                FloatingActionButton(
                    onPressed: () => {
                          _controller
                              .jumpTo(_controller.position.maxScrollExtent)
                        },
                    heroTag: null,
                    child: const Icon(Icons.arrow_downward)),
                SizedBox(width: 10),
                FloatingActionButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MessageListView(room)));
                    },
                    heroTag: null,
                    child: const Icon(Icons.refresh)),
                Expanded(child: SizedBox()),
                FloatingActionButton(
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MessageMakeView(room)))
                        },
                    heroTag: null,
                    child: const Icon(Icons.add))
              ],
            ));
      },
    );
  }
}

class Profile extends StatefulWidget {
  final int uid;
  Profile(this.uid, {Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String imgUri = '';
  String username = '';

  @override
  void initState() {
    super.initState();
    fetchUserByUid(widget.uid).then((result) {
      if (result != null) {
        setState(() {
          if (result != null) {
            username = result.name;
            imgUri = result.profile_pic;
            log(result.toString());
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 65,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: imgUri == ''
                  ? Image.asset('assets/images/avatar.png',
                      width: 55, height: 55)
                  : Image.network(imgUri,
                      errorBuilder: (context, error, stackTrace) {
                      log(error.toString());
                      return Text(error.toString());
                    }, width: 55, height: 55),
            ),
            SizedBox(height: 3.7),
            Text(
              username,
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            )
          ],
        ));
  }
}
