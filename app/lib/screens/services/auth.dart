import 'package:app/models/Colors.dart';
import 'package:app/models/UserModel.dart';
import 'package:app/screens/authenticate/sign_in.dart';
import 'package:app/screens/navbar/navbar_root.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _userFromUser(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future<void> userSignIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Fluttertoast.showToast(
          msg: "Đăng nhập thành công",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: MyColors.darkGreen,
          textColor: Colors.white,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NavBarRoot()),
        );
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: MyColors.darkGreen,
          content: Text(
            e.code,
            style: const TextStyle(fontSize: 18.0),
          ),
        ),
      );
    }
  }

  // register with email and password
  Future<void> registration({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      print('$email $password');

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((_) {
        Fluttertoast.showToast(
            msg: "Đăng ký thành công, hãy đăng nhập",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: MyColors.darkGreen,
            textColor: Colors.white,
            fontSize: 16.0);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SignIn(),
            ));
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: MyColors.darkGreen,
          content: Text(
            e.code,
            style: const TextStyle(fontSize: 18.0),
          ),
        ),
      );
    }
  }

  // sign out
  Future<void> signOutUser({
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;
    if (currentUser != null) {
      try {
        await currentUser.delete().then((value) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignIn(),
            )));
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.code,
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        );
      }
    }
  }

// Change password
  void changePassword({
    required BuildContext context,
    required String newPassword,
  }) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    try {
      await currentUser!.updatePassword(newPassword).then((value) {
        {
          Fluttertoast.showToast(
            msg: "Mật khẩu đã thay đổi, hãy đăng nhập",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: MyColors.darkGreen,
            textColor: Colors.white,
          );
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignIn(),
              ));
        }
      });
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.code,
            style: const TextStyle(fontSize: 18.0),
          ),
        ),
      );
    }
  }

  void changeEmail({
    required BuildContext context,
    required String newEmail,
  }) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    try {
      await currentUser!.updateEmail(newEmail).then((value) {
        {
          Fluttertoast.showToast(
            msg: "Email đã thay đổi, hãy đăng nhập",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: MyColors.darkGreen,
            textColor: Colors.white,
          );
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignIn(),
              ));
        }
      });
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.code,
            style: const TextStyle(fontSize: 18.0),
          ),
        ),
      );
    }
  }
}
