import 'package:flutter/material.dart';

import '../../../../components/bottom_nav_bar.dart';
import '../../booking/Booking.dart';
import '../../user_profile/userprofile.dart';
import '../home_screen.dart';



class GoBooking extends StatefulWidget {
  const GoBooking({Key? key});

  static String routeName = "/pages/homepage";
  

  @override
  _GoBookingState createState() => _GoBookingState();
}

class _GoBookingState extends State<GoBooking> {
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
      length: 2,
      child: Scaffold(
      bottomNavigationBar:   BottomnavBar( // Call the BottomnavBar widget
      onTabChanged: (index) { // Define the callback for tab change
        setState(() {
          _currentIndex = index; // Update the current index
        });
      },
      currentIndex: _currentIndex, // Pass the current index
      pageBuilder: (BuildContext context) { // Define the page builder function
        switch (_currentIndex) { // Use the current index to determine the page
          case 0:
            return HomeScreen(); // Replace YourHomePage with the actual page widget
           // Replace YourFavoritePage with the actual page widget
          case 1:
            return Booking(); // Replace YourBookingPage with the actual page widget
          case 2:
            return UserProfile(); // Replace YourProfilePage with the actual page widget
          default:
            return Container(); // Return an empty container for other indices
        }
      },
    ),
  
       
      ),
    );
  }
}
