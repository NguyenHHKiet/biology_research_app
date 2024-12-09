import 'package:app/models/Colors.dart';
import 'package:app/screens/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBarRoot extends StatefulWidget {
  const NavBarRoot({super.key});

  @override
  State<NavBarRoot> createState() => _NavBarRootState();
}

class _NavBarRootState extends State<NavBarRoot> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const Home(),
    const Center(child: Text("Messages Screen")), // Placeholder
    const Center(child: Text("Schedule Screen")), // Placeholder
    const Center(child: Text("Settings Screen")), // Placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.green.shade50
            : Theme.of(context).scaffoldBackgroundColor,
        body: _screens[_selectedIndex],
        bottomNavigationBar: SizedBox(
          height: 64,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            child: BottomNavigationBar(
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.green.shade300
                  : Colors.black,
              type: BottomNavigationBarType.fixed,
              selectedItemColor:
                  Theme.of(context).brightness == Brightness.light
                      ? MyColors.darkGreen
                      : Colors.white,
              unselectedItemColor: Colors.white60,
              showUnselectedLabels: false,
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.house_rounded),
                  label: "Trang chủ",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.add_circled_solid),
                  label: "Thêm",
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
