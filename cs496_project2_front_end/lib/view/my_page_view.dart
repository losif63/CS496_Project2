import 'package:cs496_project2_front_end/view/user_update_view.dart';
import 'package:flutter/material.dart';

class MyPageView extends StatelessWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('마이페이지'),
          elevation: 0.0,
        ),
        body: Column(
          children: [
            MyInfo(),
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
                  child: Text('회원 정보 수정', style: TextStyle(fontSize: 16))),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Text('로그아웃', style: TextStyle(fontSize: 16))),
            ),
          ],
        ));
  }
}

class MyInfo extends StatelessWidget {
  const MyInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown.withOpacity(0.3),
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset('assets/images/kakaotalk.png',
                  scale: 0.1, width: 50, height: 50),
              SizedBox(width: 10),
              Text('유저1',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
            ],
          ),
          SizedBox(height: 10),
          Text(
            '소개글',
          ),
        ],
      ),
    );
  }
}
