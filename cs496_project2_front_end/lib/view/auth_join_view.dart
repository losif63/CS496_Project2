import 'package:flutter/material.dart';

class AuthJoinView extends StatelessWidget {
  AuthJoinView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(left: 45, right: 45),
          child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      onSaved: null,
                      autocorrect: false,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          labelText: '이름', hintText: '이름을 입력해주세요'),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      onSaved: null,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          labelText: '이메일', hintText: '이메일을 입력해주세요'),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                        obscureText: true,
                        onSaved: null,
                        autocorrect: false,
                        decoration: const InputDecoration(
                            labelText: '비밀번호', hintText: '비밀번호를 입력해주세요')),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(height: 45),
                          Text('회원가입', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ])),
        ),
      ),
    );
  }
}
