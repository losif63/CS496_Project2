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
      appBar: AppBar(title: Text('방 목록'), elevation: 0.0),
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
                  itemBuilder: (builder, index) => InkWell(
                    onTap: () {},
                    child: Container(
                        padding: EdgeInsets.all(10),
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
