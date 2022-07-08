import 'package:flutter/material.dart';

class AuthView extends StatelessWidget {
  AuthView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 75),
                Container(height: 50, width: 50, color: Colors.amber), //앱 로고 박기
                const SizedBox(height: 15),
                Text('사람들과 간편하게 모임을 만들자, 모여라',
                    style: TextStyle(fontSize: 16, color: Colors.black87)),
                Padding(
                  padding: const EdgeInsets.all(45),
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
                        const SizedBox(height: 10),
                        TextButton(
                          child:
                              const Text('로그인', style: TextStyle(fontSize: 16)),
                          onPressed: () {},
                        ),
                        const SizedBox(height: 50),
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
                            CustomButtonSocial(
                                onPressedFn: () {}, image: 'kakaotalk'),
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
                                    onPressed: () {},
                                    child: const Text("회원가입",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.orange)))
                              ],
                            )
                          ],
                        )
                      ])),
                )
              ])),
    );
  }
}

class CustomButtonSocial extends StatelessWidget {
  final VoidCallback onPressedFn;
  final String image;

  const CustomButtonSocial({
    Key? key,
    required this.onPressedFn,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(20, 0, 0, 0),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
          onPressed: onPressedFn,
          child:
              //D:\programs\madcamp\cs496_2ndWeek\CS496_Project2\cs496_project2_front_end\assets\images\kakaotalk.png
              Image.asset('assets/images/kakaotalk.png',
                  height: 30, width: 30)),
    );
  }
}
