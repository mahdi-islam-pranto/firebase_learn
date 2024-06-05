import 'package:firebase_auth/firebase_auth.dart';
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
    );
  }
}
