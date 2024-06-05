import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firelearn/screens/all_post.dart';
import 'package:firelearn/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    //user already logged in or not
    //firebase init
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

// user logged in
    if (user != null) {
      Timer(const Duration(seconds: 3), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Post(),
          ),
        );
      });
    } else {
      // user not logged in
      Timer(const Duration(seconds: 3), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      });
    }
  }
}
