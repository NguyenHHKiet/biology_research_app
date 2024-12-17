import 'package:app/models/Colors.dart';
import 'package:app/screens/authenticate/sign_up.dart';
import 'package:app/screens/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  var email = "";
  var password = "";
  bool passToggle = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.yellow.shade50
            : Colors.black,
        image: const DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/bg.png'),
        ),
      ),
      // padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: SafeArea(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              child: BottomAppBar(
                child: Container(
                    decoration: BoxDecoration(
                        color: MyColors.green.shade400,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    height: 65,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Chưa có tài khoản ? ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUp(),
                                ));
                          },
                          child: const Text("Đăng ký",
                              style: TextStyle(
                                  color: Colors.brown,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                        )
                      ],
                    )),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Image.asset(
                      'assets/foodicon.png',
                      height: 100,
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "Đăng nhập",
                        style: GoogleFonts.sigmarOne(
                            textStyle: const TextStyle(
                                color: MyColors.green, fontSize: 30)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 210.0, bottom: 5),
                            child: Text(
                              "Địa chỉ Email",
                              style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? MyColors.darkGreen
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Hãy nhập địa chỉ email";
                              } else if (!value.contains("@")) {
                                return "Hãy nhập Email hợp lệ";
                              } else if (!value.contains(".com")) {
                                return "Hãy nhập Email hợp lệ";
                              }
                              return null;
                            },
                            cursorColor: MyColors.darkGreen,
                            decoration: InputDecoration(
                                hintText: "Nhập email",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 20.0),
                                filled: true,
                                fillColor: Colors.green.withOpacity(0.6),
                                border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: MyColors.green),
                                    borderRadius: BorderRadius.circular(30)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: MyColors.green),
                                    borderRadius: BorderRadius.circular(30)),
                                suffixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? MyColors.darkGreen
                                      : Colors.white,
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 240.0, bottom: 5),
                            child: Text(
                              "Mật khẩu",
                              style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? MyColors.darkGreen
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: passToggle,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Hãy nhập mật khẩu";
                              } else if (value.length < 6) {
                                return "Hãy nhập ít nhất 6 ký tự";
                              }
                              return null;
                            },
                            cursorColor: MyColors.darkGreen,
                            decoration: InputDecoration(
                                hintText: "Nhập mật khẩu",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 20.0),
                                filled: true,
                                fillColor: Colors.green.withOpacity(0.6),
                                border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: MyColors.green),
                                    borderRadius: BorderRadius.circular(30)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: MyColors.green),
                                    borderRadius: BorderRadius.circular(30)),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      passToggle = !passToggle;
                                    });
                                  },
                                  child: Icon(
                                    passToggle
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? MyColors.darkGreen
                                        : Colors.white,
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              minimumSize: const Size(200, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                var pref =
                                    await SharedPreferences.getInstance();
                                pref.setBool("Đăng nhập", true);
                                setState(() {
                                  email = emailController.text;
                                  password = passwordController.text;
                                });
                                await _auth.signInWithEmailAndPassword(
                                  context: context,
                                  email: email,
                                  password: password,
                                );
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Hãy nhập đầy đủ thông tin",
                                    backgroundColor: Colors.redAccent);
                              }
                            },
                            child: Text(
                              'Đăng nhập',
                              style: GoogleFonts.sigmarOne(
                                  textStyle: const TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              minimumSize: const Size(200, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            icon: Image.asset(
                              'assets/google.png',
                              height: 24,
                            ),
                            label: const Text(
                              'Đăng nhập với Google',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () async {
                              final user = await _auth.signInWithGoogle();
                              if (user != null) {
                                Fluttertoast.showToast(
                                    msg: "Đăng nhập Google thành công",
                                    backgroundColor: Colors.green);
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Đăng nhập Google thất bại",
                                    backgroundColor: Colors.red);
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              minimumSize: const Size(200, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            icon:
                                const Icon(Icons.facebook, color: Colors.white),
                            label: const Text(
                              'Đăng nhập với Facebook',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              final user = await _auth.signInWithFacebook();
                              if (user != null) {
                                Fluttertoast.showToast(
                                    msg: "Đăng nhập Facebook thành công",
                                    backgroundColor: Colors.green);
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Đăng nhập Facebook thất bại",
                                    backgroundColor: Colors.red);
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
