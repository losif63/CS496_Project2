import 'package:cs496_project2_front_end/model/user_model.dart';
import 'package:cs496_project2_front_end/view/auth_view.dart';
import 'package:cs496_project2_front_end/view/user_update_view.dart';
import 'package:cs496_project2_front_end/viewmodel/auth/auth_viewmodel.dart';
import 'package:cs496_project2_front_end/viewmodel/auth/kakao_login.dart';
import 'package:cs496_project2_front_end/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPageView extends StatelessWidget {
  MyPageView({Key? key}) : super(key: key);
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => UserUpdateView())));
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
                          fetchUserByUidWithoutGiven().then((value) {
                            if (value!.password == 'kakao') {
                              viewModel.logout();
                            }
                          });
                          await prefs.clear();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AuthView()),
                              (route) => false);
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
      color: Colors.brown.withOpacity(0.3),
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset('assets/images/kakaotalk.png',
                  scale: 0.1, width: 50, height: 50),
              const SizedBox(width: 10),
              Text(user.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold))
            ],
          ),
          const SizedBox(height: 10),
          Text(
            user.profile_word,
          ),
        ],
      ),
    );
  }
}
