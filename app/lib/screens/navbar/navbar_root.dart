import 'package:app/models/Colors.dart';
import 'package:app/screens/home/home.dart';
import 'package:app/screens/search/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBarRoot extends StatefulWidget {
  const NavBarRoot({super.key});

  @override
  State<NavBarRoot> createState() => _NavBarRootState();
}

class _NavBarRootState extends State<NavBarRoot> {
  // Sử dụng late để khởi tạo danh sách màn hình một lần duy nhất
  late final List<Widget> _screens;

  // Sử dụng late để khởi tạo PageController
  late PageController _pageController;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Khởi tạo danh sách màn hình
    _screens = [
      const Home(),
      const Search(),
      const Center(child: Text("Cá nhân")),
      const Center(child: Text("Cài đặt")),
    ];

    // Khởi tạo PageController
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    // Giải phóng tài nguyên PageController
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Chuyển trang mượt mà
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Sử dụng Theme để tránh lặp lại việc truy cập theme
    final theme = Theme.of(context);
    final brightness = theme.brightness;

    return SafeArea(
      child: Scaffold(
        backgroundColor: brightness == Brightness.light
            ? Colors.green.shade50
            : theme.scaffoldBackgroundColor,
        body: PageView(
          controller: _pageController,
          physics:
              const NeverScrollableScrollPhysics(), // Ngăn chặn vuốt chuyển trang
          children: _screens,
        ),
        bottomNavigationBar: SizedBox(
          height: 64,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            child: BottomNavigationBar(
              backgroundColor: brightness == Brightness.light
                  ? Colors.green.shade300
                  : Colors.black,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: brightness == Brightness.light
                  ? MyColors.darkGreen
                  : Colors.white,
              unselectedItemColor: Colors.white60,
              showUnselectedLabels: false,
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.house_rounded),
                  label: "Trang chủ",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.search_circle_fill),
                  label: "Tra cứu",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_rounded),
                  label: "Cá nhân",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.settings),
                  label: "Cài đặt",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
