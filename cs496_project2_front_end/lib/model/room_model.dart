class RoomModel {
  int r_id;
  String room_name;
  String description;
  int opener;
  String open_time;
  int max_participants;
  int cur_participants;

  RoomModel(
      {required this.r_id,
      required this.room_name,
      required this.description,
      required this.opener,
      required this.open_time,
      required this.max_participants,
      required this.cur_participants});

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
        r_id: json['r_id'],
        room_name: json['room_name'],
        description: json['description'],
        opener: json['opener'],
        open_time: json['open_time'],
        max_participants: json['max_participants'],
        cur_participants: json['cur_participants']);
  }
}

// class Room {
//   int r_id;
//   String room_name;
//   String description;
//   int opener;
//   String open_time;
//   int max_participants;
//   int cur_participants;

//   Room(
//       {required this.r_id,
//       required this.room_name,
//       required this.description,
//       required this.opener,
//       required this.open_time,
//       required this.max_participants,
//       required this.cur_participants});

//   factory Room.fromJson(Map<String, dynamic> json) {
//     return Room(
//         r_id: json['r_id'],
//         room_name: json['room_name'],
//         description: json['description'],
//         opener: json['opener'],
//         open_time: json['open_time'],
//         max_participants: json['max_participants'],
//         cur_participants: json['cur_participants']);
//   }
// }
