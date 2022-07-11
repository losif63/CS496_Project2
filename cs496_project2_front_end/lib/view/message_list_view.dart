import 'package:cs496_project2_front_end/model/message_model.dart';
import 'package:cs496_project2_front_end/viewmodel/message_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageListView extends StatelessWidget {
  const MessageListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('메세지 목록'),
            elevation: 0.0,
          ),
          body: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 120,
              child: FutureBuilder<List<MessageModel>>(
                future: fetchMessages(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData &&
                      snapshot.data!.isNotEmpty) {
                    return ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemBuilder: ((context, index) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(3.0)),
                              child: Row(
                                children: [
                                  // ClipRRect(
                                  //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  //   child: Image.network(src)
                                  // )
                                ],
                              ));
                        }),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: snapshot.data!.length);
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
              )),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => {},
          ),
        );
      },
    );
  }
}

// class ProfileImage extends 
