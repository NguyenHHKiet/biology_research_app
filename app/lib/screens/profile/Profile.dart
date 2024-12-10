import 'package:app/models/Colors.dart';
import 'package:app/screens/profile/profile_image_picker.dart';
import 'package:app/screens/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Sử dụng final cho các biến không thay đổi
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // Refactor các biến trạng thái
  bool _isPasswordVisible = true;
  String _nameValue = "";

  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  @override
  void dispose() {
    // Giải phóng tài nguyên controllers
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Tách riêng logic load tên người dùng
  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameValue = prefs.getString('myName') ?? "";
    });
  }

  // Tách riêng logic mở URL
  Future<void> _launchWebsite() async {
    final url = Uri.parse("https://hypeteq.com/");
    try {
      await launchUrl(url);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không thể mở URL: $url')),
      );
    }
  }

  // Refactor các dialog thành các method riêng biệt
  void _showInformationDialog() {
    showDialog(
      context: context,
      builder: (context) => _buildInformationDialog(),
    );
  }

  void _showEmailEditDialog() {
    _emailController.text = FirebaseAuth.instance.currentUser?.email ?? '';
    showDialog(
      context: context,
      builder: (context) => _buildEmailEditDialog(),
    );
  }

  void _showPasswordChangeDialog() {
    showDialog(
      context: context,
      builder: (context) => _buildPasswordChangeDialog(),
    );
  }

  // Widget cho các mục menu
  Widget _buildProfileMenuItem(
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.grey.withOpacity(0.2),
        child: ListTile(
          leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).brightness == Brightness.light
                  ? MyColors.darkGreen
                  : Colors.white60,
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          onTap: onTap,
        ),
      ),
    );
  }

  // Các dialog builder
  AlertDialog _buildInformationDialog() {
    return AlertDialog(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.green.shade50
          : Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        "Thông tin",
        style: GoogleFonts.muktaMahee(
          textStyle: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? MyColors.darkGreen
                : Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  "assets/hypeteq.jfif",
                  height: 60,
                  width: 70,
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  "Perception Technology Solutions. ltd",
                  style: GoogleFonts.mukta(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.light
                          ? MyColors.darkGreen
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Trang: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.light
                        ? MyColors.darkGreen
                        : Colors.white,
                  ),
                ),
                InkWell(
                  onTap: _launchWebsite,
                  child: const Text(
                    "hypeteq.com",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AlertDialog _buildEmailEditDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      title: Text(
        "Thay đổi email",
        style: GoogleFonts.kalam(
          textStyle: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? MyColors.darkGreen
                : Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _emailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Vui lòng nhập địa chỉ email";
            }
            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegex.hasMatch(value)) {
              return "Vui lòng nhập email hợp lệ";
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: FirebaseAuth.instance.currentUser?.email ?? 'Email',
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            filled: true,
            fillColor: Colors.green.withOpacity(0.6),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: MyColors.green),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Thay đổi Email'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _auth.changeEmail(
                  context: context, newEmail: _emailController.text);
            }
          },
        ),
      ],
    );
  }

  AlertDialog _buildPasswordChangeDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      title: Text(
        "Thay đổi mật khẩu",
        style: GoogleFonts.kalam(
          textStyle: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? MyColors.darkGreen
                : Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: StatefulBuilder(
        builder: (context, setState) {
          return TextFormField(
            controller: _passwordController,
            obscureText: _isPasswordVisible,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Vui lòng nhập mật khẩu";
              }
              if (value.length < 6) {
                return "Mật khẩu phải có ít nhất 6 ký tự";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Mật khẩu mới",
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              filled: true,
              fillColor: Colors.green.withOpacity(0.6),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: MyColors.green),
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
          );
        },
      ),
      actions: [
        TextButton(
          child: const Text('Thay đổi mật khẩu'),
          onPressed: () {
            _auth.changePassword(
                context: context, newPassword: _passwordController.text);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.green.shade50
          : Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 280,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.green.shade300
                        : Colors.black45,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const Text(
                            "Cá nhân",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const ProfileImagePicker(),
                    const SizedBox(height: 5),
                    Text(
                      _nameValue,
                      style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                _buildProfileMenuItem(
                    title: "Thay đổi Email",
                    icon: Icons.lock_open_outlined,
                    onTap: _showEmailEditDialog),
                _buildProfileMenuItem(
                    title: "Thay đổi Mật khẩu",
                    icon: Icons.change_circle_outlined,
                    onTap: _showPasswordChangeDialog),
                _buildProfileMenuItem(
                    title: "Thông tin",
                    icon: Icons.perm_device_information,
                    onTap: _showInformationDialog),
                _buildProfileMenuItem(
                    title: "Đăng xuất",
                    icon: Icons.logout_rounded,
                    onTap: () => _auth.signOut(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
