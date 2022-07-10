import 'package:cs496_project2_front_end/model/room_model.dart';
import 'package:cs496_project2_front_end/view/room_detail_view.dart';
import 'package:cs496_project2_front_end/view/room_make_view.dart';
import 'package:cs496_project2_front_end/viewmodel/participate_viewmodel.dart';
import 'package:cs496_project2_front_end/viewmodel/room_viewmodel.dart';
import 'package:flutter/material.dart';

class RoomListView extends StatelessWidget {
  const RoomListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: ((context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('모임하자'),
          elevation: 0.0,
        ),
        body: ListView(
          padding: EdgeInsets.all(10),
          children: const [MyRooms(), AllRooms()],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: ((context) => RoomMakeView()))),
        ),
      );
    }));
  }
}

class MyRooms extends StatelessWidget {
  const MyRooms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          '내가 참여한 방 목록',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          height: 120,
          child: FutureBuilder<List<RoomModel>>(
            future: fetchMyRooms(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: ((context, index) {
                      int maxPar = snapshot.data![index].max_participants;
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(3.0)),
                          child: Stack(
                            children: [
                              Text(
                                snapshot.data![index].room_name,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                    height: 25,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(0, 0, 0, 0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: CurParticipants(
                                      maxPar: maxPar,
                                      roomId: snapshot.data![index].r_id,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    scrollDirection: Axis.horizontal,
                  );
                } else {
                  return const Text(
                    '  현재 참여중인 방이 없습니다.',
                    style: TextStyle(color: Colors.black45),
                  );
                }
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return Container(
                  height: 80,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(color: Colors.amber));
            }),
          ),
        )
      ],
    );
  }
}

class CurParticipants extends StatefulWidget {
  const CurParticipants({
    Key? key,
    required this.maxPar,
    required this.roomId,
  }) : super(key: key);

  final int maxPar;
  final int roomId;

  @override
  State<CurParticipants> createState() => _CurParticipantsState();
}

class _CurParticipantsState extends State<CurParticipants> {
  String returnVal = '??';

  @override
  void initState() {
    super.initState();
    fetchParticipants(widget.roomId).then((value) {
      returnVal = value.length.toString();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('${returnVal}/${widget.maxPar}',
        style: const TextStyle(fontSize: 12));
  }
}

class AllRooms extends StatefulWidget {
  const AllRooms({Key? key}) : super(key: key);

  @override
  State<AllRooms> createState() => _AllRoomsState();
}

class _AllRoomsState extends State<AllRooms> {
  late Future<List<RoomModel>> _allrooms;

  @override
  void initState() {
    super.initState();
    _allrooms = fetchRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        const Text(
          '모든 방 목록',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        FutureBuilder<List<RoomModel>>(
          future: _allrooms,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  childAspectRatio: 4 / 3,
                  shrinkWrap: true,
                  children: [
                    for (var room in snapshot.data!)
                      InkWell(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              border: Border.all(color: Colors.black45),
                              borderRadius: BorderRadius.circular(3.0)),
                          child: Stack(
                            children: [
                              Text(
                                room.room_name,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: 25,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(0, 0, 0, 0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  child: CurParticipants(
                                      maxPar: room.max_participants,
                                      roomId: room.r_id),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                  ],
                );
              } else {
                return const Text(
                  '  현재 열려있는 방이 없습니다.',
                  style: TextStyle(color: Colors.black45),
                );
              }
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Container(
                height: 80,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(color: Colors.amber));
          },
        )
      ],
    );
  }
}
