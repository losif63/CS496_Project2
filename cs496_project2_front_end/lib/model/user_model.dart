class UserModel {
  int u_id;
  String name;
  String profile_word;
  String profile_pic;
  String email;
  String password;
  String birthdate;

  UserModel({
    required this.u_id,
    required this.name,
    required this.profile_word,
    required this.profile_pic,
    required this.email,
    required this.password,
    required this.birthdate,
  }); //profileWord, profilePic는 추후에 유저가 추가할 수 있도록 한다(아마)

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        u_id: json['u_id'],
        name: json['name'],
        profile_word: json['profile_word'],
        profile_pic: json['profile_pic'],
        email: json['email'],
        password: json['password'],
        birthdate: json['birthdate']);
  }
}

// class User {
//   int u_id;
//   String name;
//   String profile_word;
//   String profile_pic;
//   String email;
//   String password;
//   String birthdate;

//   User({
//     required this.u_id,
//     required this.name,
//     required this.profile_word,
//     required this.profile_pic,
//     required this.email,
//     required this.password,
//     required this.birthdate,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//         u_id: json['u_id'],
//         name: json['name'],
//         profile_word: json['profile_word'],
//         profile_pic: json['profile_pic'],
//         email: json['email'],
//         password: json['password'],
//         birthdate: json['birthdate']);
//   }
// }
