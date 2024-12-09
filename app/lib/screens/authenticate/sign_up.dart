import 'package:app/models/Colors.dart';
import 'package:app/screens/authenticate/sign_in.dart';
import 'package:app/screens/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();

  bool passToggle = true;

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void saveValue() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('myName', nameController.text.toString());
  }

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
      child: Scaffold(
          bottomNavigationBar: ClipRRect(
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
                      const Text("Đã có tài khoản ? ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignIn(),
                              ));
                        },
                        child: const Text("Đăng nhập",
                            style: TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      )
                    ],
                  )),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Container(
                      child: Column(
                        children: [
                          Lottie.asset('assets/signup.json', height: 180)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Đăng ký",
                      style: GoogleFonts.sigmarOne(
                          textStyle: const TextStyle(
                              color: MyColors.green, fontSize: 30)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 250.0, bottom: 5),
                          child: Text(
                            "Tên",
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
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Hãy nhập tên của bạn";
                            }
                            return null;
                          },
                          cursorColor: MyColors.darkGreen,
                          decoration: InputDecoration(
                              hintText: "Nhập tên",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 20.0),
                              filled: true,
                              fillColor: Colors.green.withOpacity(0.5),
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: MyColors.green),
                                  borderRadius: BorderRadius.circular(30)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: MyColors.green),
                                  borderRadius: BorderRadius.circular(30)),
                              suffixIcon: Icon(
                                Icons.person_2_outlined,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? MyColors.darkGreen
                                    : Colors.white,
                              )),
                        ),
                        const SizedBox(height: 20),
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
                              return "Hãy nhập email hợp lệ";
                            } else if (!value.contains(".com")) {
                              return "Hãy nhập email hợp lệ";
                            }
                            return null;
                          },
                          cursorColor: MyColors.darkGreen,
                          decoration: InputDecoration(
                              hintText: "Nhập email",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 20.0),
                              filled: true,
                              fillColor: Colors.green.withOpacity(0.5),
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
                        const SizedBox(height: 20),
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
                              fillColor: Colors.green.withOpacity(0.5),
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
                              saveValue();
                              await _auth.registration(
                                context: context,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Hãy nhập đầy đủ thông tin",
                                  backgroundColor: Colors.redAccent);
                            }
                            // var name = nameController.text.toString();
                          },
                          child: Text(
                            'Đăng ký',
                            style: GoogleFonts.sigmarOne(
                                textStyle: const TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
