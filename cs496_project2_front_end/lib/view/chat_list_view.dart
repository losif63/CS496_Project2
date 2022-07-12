import 'dart:developer';

import 'package:cs496_project2_front_end/model/room_model.dart';
import 'package:cs496_project2_front_end/viewmodel/room_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'message_list_view.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({Key? key}) : super(key: key);

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('방 목록'), elevation: 0.0),
      body: FutureBuilder(
          future: fetchMyRooms(),
          builder: (context, AsyncSnapshot<List<RoomModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (!snapshot.hasData) {
                log('No Data Messages');
                return Text('아직 이 방에는 메세지가 없습니다.');
              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    height: 0,
                    color: Colors.black26,
                    thickness: 1.5,
                  ),
                  itemBuilder: (builder, index) => InkWell(
                    onTap: () {
                      pushNewScreen(context,
                          screen: MessageListView(snapshot.data![index]),
                          withNavBar: false);
                    },
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data![index].room_name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            )
                          ],
                        )),
                  ),
                  itemCount: snapshot.data!.length,
                );
              }
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
