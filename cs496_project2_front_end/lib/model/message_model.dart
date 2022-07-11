class MessageModel {
  int m_id;
  int room;
  int user;
  String content;
  String send_time;

  MessageModel(
      {required this.m_id,
      required this.room,
      required this.user,
      required this.content,
      required this.send_time});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        m_id: json['m_id'],
        room: json['room'],
        user: json['user'],
        content: json['content'],
        send_time: json['send_time']);
  }
}
