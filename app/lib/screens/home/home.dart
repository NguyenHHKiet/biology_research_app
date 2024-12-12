import 'package:app/models/Colors.dart';
import 'package:app/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Future<String?>? _nameFuture;

  final Uri _url = Uri.parse('https://uminhthuong.girs.vn/');

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animateControllerOnce();
    _nameFuture = _getNameFromPreferences();
  }

  Future<void> _animateControllerOnce() async {
    await _controller.forward();
    await _controller.reverse();
  }

  Future<String?> _getNameFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('myName');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  TextStyle _getTitleTextStyle(BuildContext context) {
    return GoogleFonts.anekOdia(
      textStyle: TextStyle(
        color: Theme.of(context).brightness == Brightness.light
            ? MyColors.darkGreen
            : Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Không thể mở URL: $_url');
    }
  }

  Widget _buildGreetingRow(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Chào $name", style: _getTitleTextStyle(context)),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Profile()),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/pretty.jpg", // Hình ảnh đại diện cho người dùng
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            ),
          ),
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.green.shade50
              : Theme.of(context).scaffoldBackgroundColor,
          iconTheme: const IconThemeData(color: MyColors.darkGreen),
          title: FutureBuilder<String?>(
            // Tên người dùng sẽ được hiển thị ở đây
            future: _nameFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text(
                  "Loading...",
                  style: _getTitleTextStyle(context),
                );
              } else if (snapshot.hasError) {
                return Text(
                  "Error",
                  style: _getTitleTextStyle(context),
                );
              } else {
                String name = snapshot.data ?? "Guest";
                return _buildGreetingRow(name);
              }
            },
          ),
        ),
        body: AnimatedContainer(
          duration: const Duration(seconds: 2), // Thời gian hiệu ứng
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/nature_background.jpg'), // Hình ảnh nền về sinh vật học
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Cơ sở dữ liệu đa dạng sinh học \nVườn Quốc gia U Minh Thượng",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Colors.green,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(3.0, 3.0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(seconds: 2),
                  child: ElevatedButton(
                    onPressed: _launchUrl,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Khám Phá Ngay',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
