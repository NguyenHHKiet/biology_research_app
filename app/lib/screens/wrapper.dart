import 'package:app/screens/authenticate/authenticate.dart';
import 'package:app/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // return either Home or Authenticate widget
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          print('Firebase User: ${snapshot.data}');

          return const Home(); // Nếu người dùng đã đăng nhập
        } else {
          return const Authenticate(); // Nếu chưa đăng nhập
        }
      },
    );
  }
}
