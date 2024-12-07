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
  final _screens = [
    //Home Screen
    const Home(),
    //Messages Screen
    //Schedule Screen
    //Setting Screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.green.shade50
          : Theme.of(context).scaffoldBackgroundColor,
      body: _screens[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 52,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          child: BottomNavigationBar(
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? Colors.green.shade300
                : Colors.black,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).brightness == Brightness.light
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
                  icon: Icon(
                    Icons.restaurant,
                  ),
                  label: "Trang chủ"),
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.add_circled_solid,
                  ),
                  label: "Thêm"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_3_outlined), label: "Cá nhân"),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.settings), label: "Cài đặt"),
            ],
          ),
        ),
      ),
    );
  }
}
