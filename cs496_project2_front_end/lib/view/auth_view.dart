import 'package:cs496_project2_front_end/model/user_model.dart';
import 'package:cs496_project2_front_end/view/auth_join_view.dart';
import 'package:cs496_project2_front_end/view/control_view.dart';
import 'package:cs496_project2_front_end/viewmodel/auth/auth_viewmodel.dart';
import 'package:cs496_project2_front_end/viewmodel/auth/kakao_login.dart';
import 'package:cs496_project2_front_end/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                  const Text('사람들과 간편하게 모임을 만들자, 모여라',
                      style: TextStyle(fontSize: 16, color: Colors.black87)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(45, 30, 45, 30),
                    child: CustomLoginForm(formKey: _formKey),
                  ),
                  const Text("다른 방법으로 로그인하기",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Colors.black54)),
                  const SizedBox(height: 10),
                  KakaoLoginButton(), //TODO: 기능 구현!
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
                                    builder: ((context) => AuthJoinView())));
                          },
                          child: const Text("이메일로 회원가입",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.orange)))
                    ],
                  )
                ])),
      ),
    );
  }
}

class CustomLoginForm extends StatefulWidget {
  CustomLoginForm({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  State<CustomLoginForm> createState() => _CustomLoginFormState();
}

class _CustomLoginFormState extends State<CustomLoginForm> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget._formKey,
        child: Column(children: [
          TextFormField(
            decoration: const InputDecoration(
                labelText: '이메일', hintText: '이메일을 입력해주세요'),
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
              setState(() => email = val);
            },
            onSaved: (val) {},
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
                labelText: '비밀번호', hintText: '비밀번호를 입력해주세요'),
            obscureText: true,
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
              setState(() => password = val);
            },
            onSaved: (val) {},
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(height: 45),
                Text('로그인', style: TextStyle(fontSize: 16)),
              ],
            ),
            onPressed: () {
              if (widget._formKey.currentState!.validate()) {
                fetchUserByEmail(email).then((value) async {
                  if (value == null) {
                    //저장된 유저 정보가 없습니다. 회원가입을 먼저 해주십시오.
                  } else {
                    widget._formKey.currentState!.save();
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('email', email);
                    prefs.setString('u_id', value.u_id.toString());
                    print('prefs print: ' + prefs.toString());
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) =>
                                const ControlView()));
                  }
                });
              }
            },
          ),
        ]));
  }
}

class KakaoLoginButton extends StatelessWidget {
  final viewModel = AuthViewModel(KakaoLogin());

  KakaoLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0.0,
          primary: Colors.amber,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          maximumSize: const Size.fromHeight(50)),
      onPressed: () {
        viewModel.login().then((value) {
          if (value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext ctx) => const ControlView()));
          } else {
            //로그인에 실패했습니다.
          }
        });
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
