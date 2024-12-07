import 'package:app/provider/login_sharedpreference_provider.dart';
import 'package:app/provider/match_data_provider.dart';
import 'package:app/provider/theme_changer_provider.dart';
import 'package:app/screens/authenticate/authenticate.dart';
import 'package:app/screens/navbar/navbar_root.dart';
import 'package:app/widgets/on_boarding_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: "assets/.env"); // Đường dẫn tới tệp .env

    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (BuildContext context) => MatchDate()),
      ChangeNotifierProvider(create: (BuildContext context) => ThemeChanger()),
      ChangeNotifierProvider(
          create: (BuildContext context) => LoginSharedPreferenceProvider()),
    ], child: const BiologyResearchApp()));
  } catch (e) {
    print('Firebase initialization error: $e');
  }
}

class BiologyResearchApp extends StatefulWidget {
  const BiologyResearchApp({super.key});

  @override
  State<BiologyResearchApp> createState() => _BiologyResearchAppState();
}

class _BiologyResearchAppState extends State<BiologyResearchApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    // Replace with actual values
    options: FirebaseOptions(
      apiKey: dotenv.env['API_KEY'] ?? 'default_url',
      appId: dotenv.env['APP_ID'] ?? 'default_url',
      messagingSenderId: dotenv.env['MESSAGING_SENDER_ID'] ?? 'default_url',
      storageBucket: dotenv.env['STORAGE_BUCKET'] ?? 'default_url',
      projectId: dotenv.env['PROJECT_ID'] ?? 'default_url',
    ),
  );

  @override
  void initState() {
    Provider.of<LoginSharedPreferenceProvider>(context, listen: false)
        .getValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) print("Something went wrong");

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Builder(builder: (BuildContext context) {
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
          });
        });
  }
}
