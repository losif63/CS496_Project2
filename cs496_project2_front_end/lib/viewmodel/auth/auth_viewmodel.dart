import 'package:cs496_project2_front_end/viewmodel/auth/kakao_login.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class AuthViewModel {
  final KakaoLogin _kakaoLogin;
  bool isLogined = false;
  User? user;

  AuthViewModel(this._kakaoLogin);

  Future login() async {
    isLogined = await _kakaoLogin.login();
    print(isLogined.toString());
    if (isLogined) user = await UserApi.instance.me();
  }

  Future logout() async {
    await _kakaoLogin.logout();
    isLogined = false;
    user = null;
  }
}
