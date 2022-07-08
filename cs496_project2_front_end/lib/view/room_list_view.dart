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
          onPressed: () {},
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
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            shrinkWrap: true,
            itemCount: 15,
            itemBuilder: ((context, index) => Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(3.0)),
                  child: Stack(
                    children: [
                      const Text(
                        '새벽 4시까지 즐겁게 같이 밤샐 사람들을 구합니다.',
                        style: TextStyle(
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
                            child: const Text('4/10',
                                style: TextStyle(fontSize: 12))),
                      ),
                    ],
                  ),
                )),
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}

class AllRooms extends StatelessWidget {
  const AllRooms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        const Text(
          '현재 열려있는 방 목록',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          childAspectRatio: 4 / 3,
          shrinkWrap: true,
          children: [
            Container(
              color: Colors.amber,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.5,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.amber,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(3.0)),
              child: Stack(
                children: [
                  const Text(
                    '새벽 4시까지 즐겁게 같이 밤샐 사람들을 구합니다.',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                        child:
                            const Text('4/10', style: TextStyle(fontSize: 12))),
                  ),
                ],
              ),
            ),
            Container(
              width: 100,
              height: 75,
              color: Colors.amber,
            )
          ],
        )
      ],
    );
  }
}
