import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class BottomnavBar extends StatelessWidget {
  final void Function(int) onTabChanged;
  final int currentIndex;
  final Widget Function(BuildContext) pageBuilder; // Corrected function signature

  const BottomnavBar({
    Key? key, // Corrected definition of key parameter
    required this.onTabChanged,
    required this.currentIndex,
    required this.pageBuilder,
  }) : super(key: key); // Added super call

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            backgroundColor: Colors.white,
            color: Colors.black,
            activeColor: Colors.black,
            tabBackgroundColor: const Color.fromARGB(255, 92, 92, 92),
            gap: 8,
            padding: const EdgeInsets.all(16),
            onTabChange: onTabChanged,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              // GButton(
              //   icon: Icons.favorite,
              //   text: 'Favorite',
              // ),
              GButton(
                icon: Icons.shopping_bag_outlined,
                text: 'Booking',
              ),
              GButton(
                icon: Icons.account_circle,
                text: 'Account',
              ),
            ],
          ),
        ),
      ),
      body: pageBuilder(context), // Call pageBuilder with context
    );
  }
}
