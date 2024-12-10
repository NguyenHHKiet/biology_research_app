import 'package:app/models/CardList.dart';
import 'package:app/models/Colors.dart';
import 'package:app/screens/profile/Profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Future<String?>? _nameFuture;

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

  Widget _buildGreetingRow(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Hello $name", style: _getTitleTextStyle(context)),
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
              "assets/pretty.jpg",
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
        automaticallyImplyLeading: false, // Xóa nút back
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.green.shade50
            : Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: MyColors.darkGreen),
        title: FutureBuilder<String?>(
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio:
                0.8, // Adjust this value to control the card proportions
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: listOfCards.length,
          itemBuilder: (context, index) {
            final card = listOfCards[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.green.shade50
                  : Theme.of(context).cardColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        child: AspectRatio(
                          aspectRatio: 1, // Tỷ lệ vuông 1:1
                          child: Image.asset(
                            card.img,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          card.title,
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? MyColors.darkGreen
                                    : Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${card.icon} ${card.ret} | ${card.calories}",
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black54
                                    : Colors.white60,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
