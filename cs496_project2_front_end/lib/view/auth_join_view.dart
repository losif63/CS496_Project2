import 'dart:developer';

import 'package:flutter/material.dart';

import '../model/user_model.dart';
import '../viewmodel/user_viewmodel.dart';
import 'auth_view.dart';

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
          child: CustomJoinForm(formKey: _formKey),
        ),
      ),
    );
  }
}

class CustomJoinForm extends StatefulWidget {
  const CustomJoinForm({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  State<CustomJoinForm> createState() => _CustomJoinFormState();
}

class _CustomJoinFormState extends State<CustomJoinForm> {
  String name = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget._formKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextFormField(
            onSaved: null,
            autocorrect: false,
            keyboardType: TextInputType.name,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (val) {
              bool _isValidName(String val) {
                return RegExp(r"^[A-Za-z0-9가-힣()]+[A-Za-z0-9가-힣()\s]$")
                    .hasMatch(val);
              }

              return _isValidName(val ?? '') ? null : '이름을 두 글자 이상으로 입력해주세요';
            },
            onFieldSubmitted: (val) {
              setState(() => name = val.trim());
            },
            decoration:
                const InputDecoration(labelText: '이름', hintText: '이름을 입력해주세요'),
          ),
          const SizedBox(height: 5),
          TextFormField(
            onSaved: null,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (val) {
              bool _isValidEmail(String val) {
                return RegExp(
                        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                    .hasMatch(val);
              }

              return _isValidEmail(val ?? '') ? null : '올바른 이메일 형식으로 입력해주세요';
            },
            onFieldSubmitted: (val) {
              setState(() => email = val.trim());
            },
            decoration: const InputDecoration(
                labelText: '이메일', hintText: '이메일을 입력해주세요'),
          ),
          const SizedBox(height: 5),
          TextFormField(
              obscureText: true,
              onSaved: null,
              autocorrect: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (val) {
                bool _isValidPassword(String val) {
                  return RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[a-zA-Z]).{8,}")
                      .hasMatch(val);
                }

                return _isValidPassword(val ?? '')
                    ? null
                    : '8자리 이상의 영어와 숫자 조합의 비밀번호를 입력해주세요.';
              },
              onFieldSubmitted: (val) {
                setState(() => password = val.trim());
              },
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
            onPressed: () {
              if (widget._formKey.currentState!.validate()) {
                //server의 유저정보와 같은 것이 있는지 체크
                Future<UserModel?> currentUser = fetchUserByEmail(email);
                currentUser.then((value) async {
                  if (value == null) {
                    log('해당 이메일은 등록되지 않은 새 이메일입니다!!');
                    widget._formKey.currentState!.save();
                    Future<UserModel> futureNewUser = addUser(UserModel(
                        u_id: -1,
                        name: name,
                        profile_word: '',
                        profile_pic: '',
                        email: email,
                        password: password,
                        birthdate: ''));
                    Navigator.pop(context);
                  } else {
                    log('해당 이메일은 이미 등록되었습니다...');
                    return const SnackBar(
                        content: Text('해당 이메일은 이미 등록되었습니다..'));
                  }
                });
              }
            },
          ),
        ]));
  }
}
