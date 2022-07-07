class MessageModel {
  late int mId, room, user;
  late String content, sendTime;

  MessageModel(
      {required this.mId,
      required this.room,
      required this.user,
      required this.content,
      required this.sendTime});
}
