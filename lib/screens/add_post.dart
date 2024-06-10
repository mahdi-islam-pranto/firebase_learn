import 'package:firelearn/screens/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddPost extends StatefulWidget {
  AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref();

  bool loading = false;

  final postController = TextEditingController();

  // post added msg
  void showPostAddedMsg() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Post Added Successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Add Post"),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              maxLines: 10,
              decoration: const InputDecoration(
                  hintText: "What's on your mind?",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            RoundButton(
              title: "Add Post",
              onTap: () {
                setState(() {
                  loading = true;
                });

                databaseRef.child('Post').set({
                  'title': postController.text.toString(),
                  'id': DateTime.now().microsecondsSinceEpoch.toString()
                }).then((value) {
                  setState(() {
                    loading = false;
                  });
                  showPostAddedMsg();
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
    );
  }
}
