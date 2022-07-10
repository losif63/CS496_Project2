import 'package:cs496_project2_front_end/view/auth_view.dart';
import 'package:cs496_project2_front_end/view/control_view.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var NATIVEAPPKEY = '73209b84ec45301453398f47733a0420';
  KakaoSdk.init(nativeAppKey: NATIVEAPPKEY);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  //print('user' + email.toString());
  runApp(MyApp(email));
}

class MyApp extends StatelessWidget {
  final String? email;
  const MyApp(this.email, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'cs496_project2',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: email == null ? AuthView() : ControlView(),
    );
  }
}
