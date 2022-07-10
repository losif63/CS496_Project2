import 'package:cs496_project2_front_end/view/chat_list_view.dart';
import 'package:cs496_project2_front_end/view/my_page_view.dart';
import 'package:cs496_project2_front_end/view/room_list_view.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ControlView extends StatefulWidget {
  const ControlView({Key? key}) : super(key: key);

  @override
  State<ControlView> createState() => _ControlViewState();
}

class _ControlViewState extends State<ControlView> {
  late PersistentTabController _controller;
  late bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return [
      const RoomListView(),
      const ChatListView(),
      MyPageView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(MdiIcons.homeVariantOutline),
        title: ("HOME"),
        activeColorPrimary: Colors.amber,
        inactiveColorPrimary: Colors.black38,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(MdiIcons.forum),
        title: ("CHAT"),
        activeColorPrimary: Colors.amber,
        inactiveColorPrimary: Colors.black38,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(MdiIcons.account),
        title: ("MY"),
        activeColorPrimary: Colors.amber,
        inactiveColorPrimary: Colors.black38,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      navBarStyle: NavBarStyle.style6,
    );
    // return Scaffold(
    //   body: IndexedStack(
    //     index: _currentIndex,
    //     children: [
    //       const RoomListView(),
    //       const ChatListView(),
    //       MyPageView(),
    //     ],
    //   ),
    //   bottomNavigationBar: BottomNavigationBar(
    //     elevation: 0.0,
    //     selectedIconTheme: const IconThemeData(color: Colors.amber),
    //     selectedLabelStyle: const TextStyle(
    //         fontSize: 13, letterSpacing: 0.1, fontWeight: FontWeight.w500),
    //     unselectedLabelStyle: const TextStyle(
    //         fontSize: 13, letterSpacing: 0.1, fontWeight: FontWeight.w500),
    //     type: BottomNavigationBarType.fixed,
    //     currentIndex: _currentIndex,
    //     onTap: (index) {
    //       setState(() => _currentIndex = index);
    //     },
    //     items: const [
    //       BottomNavigationBarItem(
    //           label: 'HOME', icon: Icon(MdiIcons.homeVariantOutline)),
    //       BottomNavigationBarItem(label: 'CHAT', icon: Icon(MdiIcons.forum)),
    //       BottomNavigationBarItem(label: 'MY', icon: Icon(MdiIcons.account)),
    //     ],
    //   ),
    // );
  }
}
