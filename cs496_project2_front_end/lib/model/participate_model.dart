class ParticipateModel {
  int p_id;
  int user;
  int room;
  String join_time;

  ParticipateModel(
      {required this.p_id,
      required this.user,
      required this.room,
      required this.join_time});

  factory ParticipateModel.fromJson(Map<String, dynamic> json) {
    return ParticipateModel(
        p_id: json['p_id'],
        user: json['user'],
        room: json['room'],
        join_time: json['join_time']);
  }
}
