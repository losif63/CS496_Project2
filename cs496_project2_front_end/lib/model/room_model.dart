class RoomModel {
  late int rId, maxParticipants, curParticipants, opener;
  late String roomName, description, openTime;

  RoomModel({
    required this.rId,
    required this.roomName,
    required this.description,
    required this.opener,
    required this.openTime,
    required this.maxParticipants,
    required this.curParticipants,
  });
}
