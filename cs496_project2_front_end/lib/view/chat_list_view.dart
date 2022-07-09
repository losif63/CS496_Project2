import 'package:flutter/material.dart';

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
      body: ListView.separated(
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
        itemCount: 2,
      ),
    );
  }
}
