import 'package:cs496_project2_front_end/model/room_model.dart';
import 'package:cs496_project2_front_end/viewmodel/room_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({Key? key}) : super(key: key);

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: fetchMyRooms(),
          builder: (context, AsyncSnapshot<List<RoomModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    height: 0,
                    color: Colors.black26,
                    thickness: 1.5,
                  ),
                  itemBuilder: (builder, context) => InkWell(
                    onTap: () {},
                    child: Container(
                      height: 100,
                    ),
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
