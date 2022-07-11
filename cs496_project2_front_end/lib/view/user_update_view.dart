import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';
import '../viewmodel/user_viewmodel.dart';

class UserUpdateView extends StatelessWidget {
  UserModel user;
  UserUpdateView(this.user, {Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(left: 45, right: 45),
          child: CustomUpdateForm(formKey: _formKey, user),
        ),
      ),
    );
  }
}

class CustomUpdateForm extends StatefulWidget {
  UserModel user;
  CustomUpdateForm(
    this.user, {
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  State<CustomUpdateForm> createState() => _CustomUpdateFormState();
}

class _CustomUpdateFormState extends State<CustomUpdateForm> {
  String name = '';
  String email = '';
  String password = '';
  String profileMessage = '';
  String birthday = '';
  String profileUri = '';

  late XFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  TextEditingController ctrlr = TextEditingController();

  takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    final prefs = await SharedPreferences.getInstance();
    int uid = int.parse(prefs.getString('u_id') ?? '-1');
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

      await foo();
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    name = widget.user.name;
    email = widget.user.email;
    password = widget.user.password;
    profileMessage = widget.user.profile_word;
    birthday = widget.user.birthdate;
    profileUri = widget.user.profile_pic;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget._formKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 80,
                  backgroundImage: profileUri == ''
                      ? const AssetImage('assets/images/avatar.png')
                      : Image.network(profileUri).image,
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: ((builder) => Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Column(
                                children: <Widget>[
                                  const Text('사진 선택',
                                      style: TextStyle(fontSize: 20)),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      TextButton.icon(
                                          icon: const Icon(Icons.camera,
                                              size: 40),
                                          onPressed: () async {
                                            await takePhoto(ImageSource.camera);
                                            setState(() {});
                                          },
                                          style: ButtonStyle(foregroundColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) {
                                            return Colors.black;
                                          })),
                                          label: const Text('Camera',
                                              style: TextStyle(fontSize: 20))),
                                      TextButton.icon(
                                          icon: const Icon(Icons.photo_library,
                                              size: 40),
                                          onPressed: () async {
                                            await takePhoto(
                                                ImageSource.gallery);
                                          },
                                          style: ButtonStyle(foregroundColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) {
                                            return Colors.black;
                                          })),
                                          label: const Text('Gallery',
                                              style: TextStyle(fontSize: 20)))
                                    ],
                                  )
                                ],
                              ))));
                    },
                    child: const Icon(Icons.camera_alt,
                        color: Colors.grey, size: 40),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.name,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: name,
            validator: (val) {
              bool _isValidName(String val) {
                return RegExp(r"^[A-Za-z0-9가-힣()]+[A-Za-z0-9가-힣()\s]$")
                    .hasMatch(val);
              }

              return _isValidName(val ?? '')
                  ? null
                  : '영어와 숫자, 한글만 이용하여 두 글자 이상으로 입력해주세요';
            },
            onSaved: (val) {
              setState(() => name = val!.trim());
            },
            decoration: const InputDecoration(
                labelText: '닉네임', hintText: '닉네임을 입력해주세요'),
          ),
          const SizedBox(height: 5),
          TextFormField(
            onSaved: null,
            readOnly: true,
            initialValue: email,
            decoration: const InputDecoration(labelText: '이메일'),
          ),
          const SizedBox(height: 5),
          TextFormField(
              onSaved: null,
              readOnly: true,
              obscureText: true,
              initialValue: password,
              decoration: const InputDecoration(labelText: '비밀번호')),
          const SizedBox(height: 5),
          TextFormField(
              autocorrect: false,
              initialValue: profileMessage,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: null,
              onSaved: (val) {
                setState(() => profileMessage = val!.trim());
              },
              decoration: const InputDecoration(
                  labelText: '프로필 상태 메세지', hintText: '프로필 상태 메세지를 입력해주세요.')),
          const SizedBox(height: 5),
          TextFormField(
              controller: ctrlr,
              onSaved: null,
              readOnly: true,
              validator: null,
              onTap: () async {
                DateTime? date = DateTime(2000);
                FocusScope.of(context).requestFocus(FocusNode());
                date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100));
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
              decoration: const InputDecoration(labelText: '생년월일')),
          const SizedBox(height: 20),
          ElevatedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(height: 45),
                Text('정보 수정', style: TextStyle(fontSize: 16)),
              ],
            ),
            onPressed: () {
              if (widget._formKey.currentState!.validate()) {
                widget._formKey.currentState!.save();
                updateUser(UserModel(
                    u_id: widget.user.u_id,
                    name: name,
                    profile_word: profileMessage,
                    profile_pic: profileUri,
                    email: email,
                    password: password,
                    birthdate: birthday));
                Navigator.pop(context);
              } else {
                log('모든 정보를 조건에 맞게 입력해주세요.');
                SnackBar(content: Text('모든 정보를 조건에 맞게 입력해주세요.'));
              }
            },
          ),
        ]));
  }
}
