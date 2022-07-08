import 'package:cs496_project2_front_end/view/auth_view.dart';
import 'package:cs496_project2_front_end/view/control_view.dart';
import 'package:cs496_project2_front_end/view/my_page_view.dart';
import 'package:cs496_project2_front_end/view/room_chat_view.dart';
import 'package:flutter/material.dart';

import 'package:cs496_project2_front_end/view/room_list_view.dart';
import 'package:cs496_project2_front_end/view/room_detail_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'cs496_project2',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: ControlView(),
    );
  }
}
