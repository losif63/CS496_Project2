import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';
import '../viewmodel/user_viewmodel.dart';

class UserUpdateView extends StatelessWidget {
  UserUpdateView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(left: 45, right: 45),
          child: CustomUpdateForm(formKey: _formKey),
        ),
      ),
    );
  }
}

class CustomUpdateForm extends StatefulWidget {
  const CustomUpdateForm({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  State<CustomUpdateForm> createState() => _CustomUpdateFormState();
}

class _CustomUpdateFormState extends State<CustomUpdateForm> {
  String profileUri = '';
  String name = '';
  String email = '';
  String password = '';
  String profileMessage = '';
  String birthday = '';
  TextEditingController ctrlr = TextEditingController();
  late XFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Future<UserModel?> currentUser = getCurrentUser();
    return Form(
        key: widget._formKey,
        child: FutureBuilder<UserModel?>(
            future: currentUser,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                profileUri = snapshot.data!.profile_pic;
                name = snapshot.data!.name;
                email = snapshot.data!.email;
                password = snapshot.data!.password;
                profileMessage = snapshot.data!.profile_word;
                birthday = snapshot.data!.birthdate;

                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      imageProfile(profileUri),
                      const SizedBox(height: 5),
                      TextFormField(
                        onSaved: null,
                        autocorrect: false,
                        keyboardType: TextInputType.name,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        initialValue: snapshot.data!.name,
                        validator: (val) {
                          bool _isValidName(String val) {
                            return RegExp(
                                    r"^[A-Za-z0-9가-힣()]+[A-Za-z0-9가-힣()\s]$")
                                .hasMatch(val);
                          }

                          return _isValidName(val ?? '')
                              ? null
                              : '이름을 두 글자 이상으로 입력해주세요';
                        },
                        onFieldSubmitted: (val) {
                          setState(() => name = val.trim());
                        },
                        decoration: const InputDecoration(
                            labelText: '이름', hintText: '이름을 입력해주세요'),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        onSaved: null,
                        autocorrect: false,
                        readOnly: true,
                        initialValue: snapshot.data!.email,
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) {
                          bool _isValidEmail(String val) {
                            return RegExp(
                                    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                .hasMatch(val);
                          }

                          return _isValidEmail(val ?? '')
                              ? null
                              : '올바른 이메일 형식으로 입력해주세요';
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
                          initialValue: snapshot.data!.password,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) {
                            bool _isValidPassword(String val) {
                              return RegExp(
                                      r"(?=.*\d)(?=.*[a-z])(?=.*[a-zA-Z]).{8,}")
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
                      const SizedBox(height: 5),
                      TextFormField(
                          onSaved: null,
                          autocorrect: false,
                          initialValue: snapshot.data!.profile_word,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: null,
                          onFieldSubmitted: null,
                          decoration: const InputDecoration(
                              labelText: '프로필 상태 메세지',
                              hintText: '프로필 상태 메세지를 입력해주세요.')),
                      const SizedBox(height: 5),
                      TextFormField(
                          controller: ctrlr,
                          onSaved: null,
                          readOnly: true,
                          autocorrect: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: null,
                          onFieldSubmitted: null,
                          onTap: () async {
                            DateTime? date = DateTime(2000);
                            FocusScope.of(context).requestFocus(FocusNode());
                            date = (await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100)));
                            if (date != null) {
                              birthday = date
                                  .toIso8601String()
                                  .substring(0, 10)
                                  .replaceAll('-', '/');
                              log(birthday);
                              setState(() {});
                              ctrlr.text = date
                                  .toIso8601String()
                                  .substring(0, 10)
                                  .replaceAll('-', '/');
                            }
                          },
                          decoration: const InputDecoration(
                              labelText: '생년월일', hintText: '생년월일을 선택하세요')),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(height: 45),
                            Text('정보수정', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        onPressed: () {
                          log('ProfileUri: $profileUri');
                          log('Name: $name');
                          log('Email: $email');
                          log('Password: $password');
                          log('ProfileMessage: $profileMessage');
                          log('Birthday: $birthday');
                          // if (widget._formKey.currentState!.validate()) {
                          //   //server의 유저정보와 같은 것이 있는지 체크
                          //   Future<UserModel?> currentUser =
                          //       fetchUserByEmail(email);
                          //   currentUser.then((value) async {
                          //     if (value == null) {
                          //       log('해당 이메일은 등록되지 않은 새 이메일입니다!!');
                          //       widget._formKey.currentState!.save();
                          //       Future<UserModel> futureNewUser = addUser(
                          //           UserModel(
                          //               u_id: -1,
                          //               name: name,
                          //               profile_word: '',
                          //               profile_pic: '',
                          //               email: email,
                          //               password: password,
                          //               birthdate: ''));
                          //       Navigator.pop(context);
                          //     } else {
                          //       log('해당 이메일은 이미 등록되었습니다...');
                          //       return const SnackBar(
                          //           content: Text('해당 이메일은 이미 등록되었습니다..'));
                          //     }
                          //   });
                          // }
                        },
                      ),
                    ]);
              } else {
                return const Text('No User Found');
              }
            }));
  }

  Widget imageProfile(String url) {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80,
            backgroundImage: url == ''
                ? const AssetImage('assets/images/avatar.png')
                : Image.network(url).image,
          ),
          Positioned(
              bottom: 20,
              right: 20,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context, builder: ((builder) => bottomSheet()));
                },
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.grey,
                  size: 40,
                ),
              ))
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: <Widget>[
            const Text(
              '사진 선택',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton.icon(
                    icon: const Icon(Icons.camera, size: 50),
                    onPressed: () async {
                      await takePhoto(ImageSource.camera);
                    },
                    style: ButtonStyle(foregroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      return Colors.black;
                    })),
                    label:
                        const Text('Camera', style: TextStyle(fontSize: 20))),
                TextButton.icon(
                    icon: const Icon(
                      Icons.photo_library,
                      size: 50,
                    ),
                    onPressed: () async {
                      await takePhoto(ImageSource.gallery);
                    },
                    style: ButtonStyle(foregroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      return Colors.black;
                    })),
                    label:
                        const Text('Gallery', style: TextStyle(fontSize: 20)))
              ],
            )
          ],
        ));
  }

  takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    final prefs = await SharedPreferences.getInstance();
    int uid = int.parse(prefs.getString('u_id') ?? '-1');
    setState(() {
      if (pickedFile != null) {
        _imageFile = pickedFile;
        log(_imageFile.path);
        foo() async {
          http.MultipartRequest request = http.MultipartRequest(
              'POST', Uri.parse('http://192.249.18.152/profilepic/${uid}'));

          request.files.add(await http.MultipartFile.fromPath(
              _imageFile.name, _imageFile.path));
          http.StreamedResponse response = await request.send();
          if (response.statusCode == 200) {
            profileUri = await response.stream.bytesToString();
            log(profileUri);
          }
        }

        foo();
      }
    });
  }
}

Future<UserModel?> getCurrentUser() async {
  final prefs = await SharedPreferences.getInstance();
  int uid = int.parse(prefs.getString('u_id') ?? '-1');
  if (uid < 0) return null;
  return fetchUserByUid(uid);
}
