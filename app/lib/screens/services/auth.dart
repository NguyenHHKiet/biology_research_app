import 'package:app/models/Colors.dart';
import 'package:app/models/UserModel.dart';
import 'package:app/screens/authenticate/sign_in.dart';
import 'package:app/screens/navbar/navbar_root.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  void _showToast({
    required String message,
    required Color backgroundColor,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
    );
  }

  void _showSnackBar({
    required BuildContext context,
    required String message,
    Color backgroundColor = MyColors.darkGreen,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Text(
          message,
          style: const TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  // Sign in anonymously
  Future<UserModel?> signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print("SignInAnon Error: ${e.toString()}");
      return null;
    }
  }

  // Sign in with email and password
  Future<void> signInWithEmailAndPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _showToast(
          message: "Đăng nhập thành công", backgroundColor: MyColors.darkGreen);
      _navigateTo(context, const NavBarRoot());
    } on FirebaseAuthException catch (e) {
      _showSnackBar(
          context: context, message: e.message ?? "Đăng nhập thất bại");
    }
  }

  // Register with email and password
  Future<void> registerUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _showToast(
          message: "Đăng ký thành công, hãy đăng nhập",
          backgroundColor: MyColors.darkGreen);
      _navigateTo(context, const SignIn());
    } on FirebaseAuthException catch (e) {
      _showSnackBar(context: context, message: e.message ?? "Đăng ký thất bại");
    }
  }

  // Sign out user
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      _navigateTo(context, const SignIn());
    } catch (e) {
      _showSnackBar(context: context, message: "Đăng xuất thất bại");
    }
  }

  // Change password
  Future<void> changePassword({
    required BuildContext context,
    required String newPassword,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
        _showToast(
            message: "Mật khẩu đã thay đổi, hãy đăng nhập",
            backgroundColor: MyColors.darkGreen);
        _navigateTo(context, const SignIn());
      } else {
        _showSnackBar(context: context, message: "Người dùng chưa đăng nhập");
      }
    } on FirebaseAuthException catch (e) {
      _showSnackBar(
          context: context, message: e.message ?? "Đổi mật khẩu thất bại");
    }
  }

  // Change email
  Future<void> changeEmail({
    required BuildContext context,
    required String newEmail,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await user.updateEmail(newEmail);
        _showToast(
            message: "Email đã thay đổi, hãy đăng nhập",
            backgroundColor: MyColors.darkGreen);
        _navigateTo(context, const SignIn());
      } else {
        _showSnackBar(context: context, message: "Người dùng chưa đăng nhập");
      }
    } on FirebaseAuthException catch (e) {
      _showSnackBar(
          context: context, message: e.message ?? "Đổi email thất bại");
    }
  }
}
