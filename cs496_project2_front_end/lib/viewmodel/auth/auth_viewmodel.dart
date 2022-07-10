import 'package:cs496_project2_front_end/model/user_model.dart';
import 'package:cs496_project2_front_end/viewmodel/auth/kakao_login.dart';
import 'package:cs496_project2_front_end/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel {
  final KakaoLogin _kakaoLogin;
  bool isLogined = false;
  User? user;

  AuthViewModel(this._kakaoLogin);

  Future<bool> login() async {
    String state = '';
    isLogined = await _kakaoLogin.login();
    print(isLogined.toString());
    if (isLogined) {
      user = await UserApi.instance.me();
      String email = user?.kakaoAccount?.email ?? '';
      if (email == '') {
        //email이 없는데? 유저를 특정할 수 있는 정보가 없다! 이럴 땐 어카지
        print('what to do when this error occurs...?');
        state = 'emailerror';
      } else {
        print('here ' + email);
        await fetchUserByEmail(email).then((value) async {
          if (value == null) {
            //user가 kakao로 우리 앱에 가입한 적이 없는 경우
            UserModel userByUserModel = UserModel(
                u_id: 0,
                name: user?.kakaoAccount?.profile?.nickname ?? '',
                profile_word: '',
                profile_pic: user?.kakaoAccount?.profile?.profileImageUrl ?? '',
                email: user?.kakaoAccount?.email ?? '',
                password: 'kakao',
                birthdate: user?.kakaoAccount?.legalBirthDate ?? '');
            addUser(userByUserModel).then((value) async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('email', email);
              prefs.setString('u_id', value.u_id.toString());
              print('useradd');
              state = 'useradd';
            });
          } else {
            //처음보는 유저가 아닐 때!! 유저 정보 sharedpreference에 저장 -> navigator!
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('email', email);
            prefs.setString('u_id', value.u_id.toString());
            print('userlogin');
            state = 'userlogin';
          }
        });
      }
      print('state: ' + state);
    }
    if (state == 'useradd' || state == 'userlogin') {
      return true;
    } else {
      return false;
    }
  }

  Future logout() async {
    await _kakaoLogin.logout();
    isLogined = false;
    user = null;
  }
}
