import 'package:firelearn/screens/all_post.dart';
import 'package:firelearn/screens/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddPost extends StatefulWidget {
  AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Post');

  bool loading = false;

  final postController = TextEditingController();
  final titleController = TextEditingController();

// Post added message
  void showPostAddedMsg() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Post Added Successfully',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Add Post"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: titleController,
                maxLines: 2,
                decoration: const InputDecoration(
                    hintText: "Write post title", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: postController,
                maxLines: 10,
                decoration: const InputDecoration(
                    hintText: "What's on your mind? ",
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              RoundButton(
                title: "Add Post",
                onTap: () {
                  DateTime now = DateTime.now();
                  int year = now.year;
                  int month = now.month;
                  int day = now.day;

                  String id = DateTime.now().microsecondsSinceEpoch.toString();
                  setState(() {
                    loading = true;
                  });
                  // adding node to the database (create data as child - sub child)
                  databaseRef.child(id).set({
                    'title': titleController.text.toString(),
                    'description': postController.text.toString(),
                    'time': "$year - $month - $day",
                    'id': id,
                  }).then((value) {
                    setState(() {
                      loading = false;
                    });
                    showPostAddedMsg();
                    // return to post page
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Post(),
                        ));
                  }).catchError((error) {
                    setState(() {
                      loading = false;
                    });
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                        error.toString(),
                      )),
                    );
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
