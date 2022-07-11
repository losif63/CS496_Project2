import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageListView extends StatelessWidget {
  const MessageListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('메세지 목록'),
            elevation: 0.0,
          ),
        );
      },
    );
  }
}
