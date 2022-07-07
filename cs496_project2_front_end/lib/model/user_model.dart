class UserModel {
  late int uId;
  late String name, profileWord, profilePic, userId, email, birthdate;

  UserModel(
      {required this.uId,
      required this.name,
      required this.profileWord,
      required this.profilePic,
      required this.userId,
      required this.email,
      required this.birthdate}); //profileWord, profilePic는 추후에 유저가 추가할 수 있도록 한다(아마)
}
