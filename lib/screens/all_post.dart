import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firelearn/screens/add_post.dart';
import 'package:firelearn/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  //firebase init
  FirebaseAuth _auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchFilter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("POST PAGE"),
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut().then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ));
                });
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPost(),
                ));
          },
          child: const Icon(Icons.add)),
      body: Column(
        children: [
          // Search Box
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: searchFilter,
              decoration: const InputDecoration(
                hintText: "Search",
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
              ),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),

          // fetch data from firebase using Strem Builder
          // Expanded(
          //     child: StreamBuilder(
          //         stream: ref.onValue,
          //         builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          //           if (snapshot.hasData) {
          //             // get the data and make the data in Map
          //             Map<dynamic, dynamic> map =
          //                 snapshot.data!.snapshot.value as dynamic;
          //             List<dynamic> list = [];
          //             list.clear();
          //             list = map.values.toList();

          //             return ListView.builder(
          //               itemCount: snapshot.data!.snapshot.children.length,
          //               itemBuilder: (context, index) {
          //                 return ListTile(
          //                   title: Text(list[index]["title"]),
          //                   subtitle: Text(list[index]["description"]),
          //                 );
          //               },
          //             );
          //           } else {
          //             return const CircularProgressIndicator();
          //           }
          //         })),

          // fetch data from database using FirebaseAnimatedList widget
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              defaultChild: const Text("Loading"),
              itemBuilder: (context, snapshot, animation, index) {
                // title from firebase
                final title = snapshot.child('title').value.toString();

                // search functionality conditions
                if (searchFilter.text.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListTile(
                      tileColor: Colors.green[50],
                      // post title
                      title: Text(snapshot.child('title').value.toString()),
                      // post description
                      subtitle:
                          Text(snapshot.child('description').value.toString()),
                      // time
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.child('time').value.toString(),
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  );

                  // search condition using title
                } else if (title
                    .toLowerCase()
                    .contains(searchFilter.text.toLowerCase().toString())) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListTile(
                      tileColor: Colors.green[50],
                      // post title
                      title: Text(snapshot.child('title').value.toString()),
                      // post description
                      subtitle:
                          Text(snapshot.child('description').value.toString()),
                      // time
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.child('time').value.toString(),
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
