import 'package:cs496_project2_front_end/view/auth_join_view.dart';
import 'package:cs496_project2_front_end/viewmodel/auth/auth_viewmodel.dart';
import 'package:cs496_project2_front_end/viewmodel/auth/kakao_login.dart';
import 'package:flutter/material.dart';

class AuthView extends StatelessWidget {
  AuthView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 50, width: 50, color: Colors.amber), //앱 로고 박기
                  const SizedBox(height: 15),
                  Text('사람들과 간편하게 모임을 만들자, 모여라',
                      style: TextStyle(fontSize: 16, color: Colors.black87)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(45, 30, 45, 30),
                    child: Form(
                        key: _formKey,
                        child: Column(children: [
                          TextFormField(
                            onSaved: null,
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                labelText: '이메일', hintText: '이메일을 입력해주세요'),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                              obscureText: true,
                              onSaved: null,
                              autocorrect: false,
                              decoration: const InputDecoration(
                                  labelText: '비밀번호', hintText: '비밀번호를 입력해주세요')),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                SizedBox(height: 45),
                                Text('로그인', style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            onPressed: () {},
                          ),
                          const SizedBox(height: 45),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("다른 방법으로 로그인하기",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey,
                                  )),
                              const SizedBox(height: 10),
                              KakaoLoginButton(),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("계정이 없으신가요?",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black87)),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    AuthJoinView())));
                                      },
                                      child: const Text("이메일로 회원가입",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.orange)))
                                ],
                              )
                            ],
                          )
                        ])),
                  ),
                ])),
      ),
    );
  }
}

class KakaoLoginButton extends StatelessWidget {
  final viewModel = AuthViewModel(KakaoLogin());

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0.0,
          primary: Colors.amber,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          maximumSize: const Size.fromHeight(50)),
      onPressed: () async {
        await viewModel.login();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/kakaotalk.png', height: 30, width: 30),
          SizedBox(width: 10),
          Text('카카오톡으로 로그인하기')
        ],
      ),
    );
  }
}
