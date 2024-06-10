import 'package:flutter/material.dart';

import '../../splash/splash_screen.dart';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<String> urls = [
    "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/29/6a/e2/f4/long-beach-hotel.jpg?w=1200&h=-1&s=1",
    "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/26/e2/9f/60/grand-sylhet-hotel-resort.jpg?w=1100&h=-1&s=1",
    "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/44/ea/2f/royal-tulip-sea-pearl.jpg?w=1200&h=-1&s=1",
    "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/29/08/c6/62/amari-dhaka-arial-shot.jpg?w=1200&h=-1&s=1",
    "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/29/0c/cb/10/exterior.jpg?w=1200&h=-1&s=1",
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // drawer:  NavBar(),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(200),
          child: AppBar(
  centerTitle: true,
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
      // Add the functionality to navigate back
      Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  const SplashScreen(),
                            ),
                          );
    },
  ),
  title: const Text(
    'gobooking',
    style: TextStyle(
      color: Colors.white,
      fontFamily: 'Raleway',
      fontSize: 22,
      fontWeight: FontWeight.w400,
    ),
  ),
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(
            "https://assets-global.website-files.com/645cf73a1399f9f6ed09a0e8/645cf73a1399f900e009a8cc_Hero-Wide-SaintMartin-SintMaarten-p-1600.jpeg"),
        fit: BoxFit.fill,
      ),
    ),
  ),
)

        ),
        body: Body(urls: urls),

        // bottomNavigationBar: BottomnavBar(
        //   onTabChanged: (index) {
        //     setState(() {
        //       currentIndex = index;
        //     });
        //   },
        //   currentIndex: currentIndex,
        //   pageBuilder: (BuildContext context) { // Adjusted function signature
        //     switch (currentIndex) { // Use currentIndex instead of index
        //       case 0:
        //         return const GoBooking();
        //       case 1:
        //         return const favourite();
        //       case 2:
        //         return const Booking();
        //       case 3:
        //         return const UserProfile();
        //       default:
        //         return Container();
        //     }
        //   },
        // ),
      ),
    );
  }
}

