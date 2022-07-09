import 'package:cs496_project2_front_end/model/user_model.dart';
import 'package:cs496_project2_front_end/viewmodel/auth/kakao_login.dart';
import 'package:cs496_project2_front_end/viewmodel/user_viewmodel.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel {
  final KakaoLogin _kakaoLogin;
  bool isLogined = false;
  User? user;

  AuthViewModel(this._kakaoLogin);

  Future login() async {
    isLogined = await _kakaoLogin.login();
    print(isLogined.toString());
    if (isLogined) {
      user = await UserApi.instance.me();
      String email = user?.kakaoAccount?.email ?? '';
      if (email == '') {
      } else {
        //모르겠다!!!!!!!!!!!!!!! TODO
        /*fetchUserByEmail(email).then((value) {
          if (value == null) {
            UserModel userByUserModel = UserModel(
                u_id: 0,
                name: user?.kakaoAccount?.name ?? '',
                profile_word: '',
                profile_pic: '',
                email: user?.kakaoAccount?.email ?? '',
                password: 'kakao',
                birthdate: '');
            print(userByUserModel.name.toString() +
                ' ' +
                userByUserModel.email.toString());
            var addedUser = addUser(userByUserModel);
          }
        });*/
      }
    }
  }

  Future logout() async {
    await _kakaoLogin.logout();
    isLogined = false;
    user = null;
  }
}
