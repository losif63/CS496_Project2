import 'package:cs496_project2_front_end/model/user_model.dart';
import 'package:cs496_project2_front_end/view/auth_view.dart';
import 'package:cs496_project2_front_end/view/user_update_view.dart';
import 'package:cs496_project2_front_end/viewmodel/auth/auth_viewmodel.dart';
import 'package:cs496_project2_front_end/viewmodel/auth/kakao_login.dart';
import 'package:cs496_project2_front_end/viewmodel/user_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPageView extends StatefulWidget {
  MyPageView({Key? key}) : super(key: key);

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final viewModel = AuthViewModel(KakaoLogin());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('마이페이지'),
          elevation: 0.0,
        ),
        body: FutureBuilder(
            future: fetchUserByUidWithoutGiven(),
            builder: (context, AsyncSnapshot<UserModel?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  return Column(
                    children: [
                      MyInfo(snapshot.data!),
                      InkWell(
                        onTap: () {
                          pushNewScreen(context,
                                  screen: UserUpdateView(snapshot.data!),
                                  withNavBar: false)
                              .then((value) => setState(() {}));
                        },
                        child: Container(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: const Text('회원 정보 수정',
                                style: TextStyle(fontSize: 16))),
                      ),
                      InkWell(
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          if (snapshot.data!.password == 'kakao') {
                            viewModel.logout();
                          }
                          await prefs.clear();
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => AuthView()));
                          ;
                          //navigation getoffall 하고 authview로
                        },
                        child: Container(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: const Text('로그아웃',
                                style: TextStyle(fontSize: 16))),
                      ),
                    ],
                  );
                }
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }
}

class MyInfo extends StatelessWidget {
  MyInfo(this.user, {Key? key}) : super(key: key);
  UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber.withOpacity(0.4),
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: (user.profile_pic == '')
                ? const AssetImage('assets/images/avatar.png')
                : Image.network(user.profile_pic).image,
          ),
          const SizedBox(height: 5),
          Text(user.name,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Icon(MdiIcons.text, color: Color.fromARGB(255, 71, 71, 71)),
            const SizedBox(width: 5),
            Flexible(
                fit: FlexFit.tight,
                child: Text(
                    (user.profile_word == '')
                        ? '소개글을 등록해주세요.'
                        : user.profile_word,
                    maxLines: 4,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 71, 71, 71))))
          ]),
          //const Flexible(fit: FlexFit.tight, child: SizedBox(height: 10)),
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            const Icon(MdiIcons.cake, color: Color.fromARGB(255, 71, 71, 71)),
            const SizedBox(width: 5),
            Text((user.birthdate == '') ? '생일 정보를 등록해주세요.' : user.birthdate,
                style: const TextStyle(color: Color.fromARGB(255, 71, 71, 71)))
          ])
        ],
      ),
    );
  }
}
