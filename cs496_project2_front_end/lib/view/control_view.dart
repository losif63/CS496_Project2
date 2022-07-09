import 'package:cs496_project2_front_end/view/chat_list_view.dart';
import 'package:cs496_project2_front_end/view/my_page_view.dart';
import 'package:cs496_project2_front_end/view/room_list_view.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ControlView extends StatefulWidget {
  const ControlView({Key? key}) : super(key: key);

  @override
  State<ControlView> createState() => _ControlViewState();
}

class _ControlViewState extends State<ControlView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          RoomListView(),
          ChatListView(),
          MyPageView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        selectedIconTheme: const IconThemeData(color: Colors.amber),
        selectedLabelStyle: const TextStyle(
            fontSize: 13, letterSpacing: 0.1, fontWeight: FontWeight.w500),
        unselectedLabelStyle: const TextStyle(
            fontSize: 13, letterSpacing: 0.1, fontWeight: FontWeight.w500),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
              label: 'HOME', icon: Icon(MdiIcons.homeVariantOutline)),
          BottomNavigationBarItem(label: 'CHAT', icon: Icon(MdiIcons.forum)),
          BottomNavigationBarItem(label: 'MY', icon: Icon(MdiIcons.account)),
        ],
      ),
    );
  }
}
