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
  ValueNotifier<bool> _notifier = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('방 목록'), elevation: 0.0),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1), () {
            _notifier.value = !_notifier.value;
            print('refresh!');
            print(_notifier.toString());
          });
        },
        child: ValueListenableBuilder(
            valueListenable: _notifier,
            builder: (BuildContext bcx, bool val, Widget? child) {
              return ChatList();
            }),
      ),
    );
  }
}

class ChatList extends StatefulWidget {
  const ChatList({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  void didUpdateWidget(covariant ChatList oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchMyRooms(),
        builder: (context, AsyncSnapshot<List<RoomModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              log('No Data Messages');
              return Container(
                height: 80,
                alignment: Alignment.center,
                child: Text(
                  '참여한 모임방이 없습니다.\nHOME탭에서 열려있는 모임에 가입해보세요!',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              );
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
        });
  }
}
