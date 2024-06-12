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
  //firebase inits
  FirebaseAuth _auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  // controllers
  final searchFilter = TextEditingController();
  final updateTitleController = TextEditingController();
  final updateDescriptionController = TextEditingController();

  // post added msg
  void showPostUpdateMsg() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Post Updated Successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // post delete msg
  void showPostDeleteMsg() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Post Deleted Successfully'),
        backgroundColor: Colors.red,
      ),
    );
  }

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
                // border: OutlineInputBorder(
                //     borderSide: BorderSide(color: Colors.green)),
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
              defaultChild: const SizedBox(
                height: 900.0,
                width: 900.0,
                child: Center(child: CircularProgressIndicator()),
              ),
              itemBuilder: (context, snapshot, animation, index) {
                // title from firebase
                final title = snapshot.child('title').value.toString();

                // search functionality conditions
                if (searchFilter.text.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListTile(
                        shape: Border.all(),
                        tileColor: Colors.green[50],
                        // post title
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(snapshot.child('title').value.toString()),
                            Text(
                              snapshot.child('time').value.toString(),
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.black54),
                            ),
                          ],
                        ),
                        // post description
                        subtitle: Text(
                            snapshot.child('description').value.toString()),
                        // time
                        trailing: PopupMenuButton(
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                child: ListTile(
                              onTap: () {
                                myAlertDialog(
                                    // old title
                                    snapshot.child('title').value.toString(),
                                    //old description
                                    snapshot
                                        .child('description')
                                        .value
                                        .toString(),
                                    // post id
                                    snapshot.child('id').value.toString());
                              },
                              leading: const Icon(Icons.edit_outlined),
                              title: const Text("Edit"),
                            )),
                            PopupMenuItem(
                                child: ListTile(
                              onTap: () {
                                ref
                                    .child(
                                        snapshot.child('id').value.toString())
                                    .remove()
                                    .then((value) {
                                  showPostDeleteMsg();
                                });
                              },
                              leading: Icon(Icons.delete_outline),
                              title: Text("Delete"),
                            )),
                          ],
                        )),
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
          ),
        ],
      ),
    );
  }

// function for showing popup menu to update and delete post
  Future<void> myAlertDialog(String title, description, id) async {
    updateTitleController.text = title;
    updateDescriptionController.text = description;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: updateTitleController,
                  decoration: const InputDecoration(
                    hintText: "title",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: updateDescriptionController,
                  maxLines: 6, // Reduced maxLines to avoid excessive space
                  decoration: const InputDecoration(
                    hintText: "description",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                //update post title and description
                ref.child(id).update({
                  "title": updateTitleController.text.toString(),
                  "description": updateDescriptionController.text.toString()
                }).then((value) {
                  showPostUpdateMsg();
                }).catchError((error) {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                      error.toString(),
                    )),
                  );
                });
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
