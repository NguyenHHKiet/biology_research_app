import 'package:app/provider/login_sharedpreference_provider.dart';
import 'package:app/provider/theme_changer_provider.dart';
import 'package:app/screens/navbar/navbar_root.dart';
import 'package:app/widgets/on_boarding_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // return either Home or Authenticate widget
    return Consumer<LoginSharedPreferenceProvider>(
        builder: (context, provider, _) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Biology Research App',
        themeMode: Provider.of<ThemeChanger>(context).themeMode,
        theme: ThemeData(brightness: Brightness.light),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: provider.getBoolLogin == true
            ? const NavBarRoot()
            : const OnBoardingWidget(),
      );
    });
  }
}
