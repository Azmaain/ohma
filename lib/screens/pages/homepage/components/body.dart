import 'package:flutter/material.dart';

import '../../../../components/travelcard.dart';
import '../../Search/search.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.urls,
  });

  final List<String> urls;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Button action
                 Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  const Search(),
                            ),
                          );
                   
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                minimumSize: const Size.square(50), // Button size
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.hotel,
                    color: Colors.black, // Icon color
                  ),
                  SizedBox(width: 8), // Add space between the icon and text
                  Text(
                    'Hotel',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.black, // Text color
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
            height: 25), // Add space between the button and tab controller
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(
                  indicatorColor: Color.fromRGBO(1, 60, 148, 1),
                  unselectedLabelColor: Color.fromARGB(255, 132, 132, 132),
                  labelColor: Color.fromARGB(255, 0, 0, 0),
                  labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  tabs: [
                    Tab(
                      text: "Trending",),
                    Tab(text: "Promotion"),
                    
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: TabBarView(
                    children: [
                      //Now let's create our first tab page
                      ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          //Now let's add and test our first card
                          travelCard(
                              urls[0], "The Long Beach", "Cox's Bazar", 5),
                          travelCard(urls[1], "Grand Sylhet Hotel And Resort",
                              "Cox's Bazar", 5),
                          travelCard(
                              urls[2],
                              " The Hotel Sea Pearl Beach Resort",
                              "Bandarban",
                              5),
                        ],
                      ),
                      ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          //Here you can add whatever you want
                          travelCard(urls[3], "Hotel Aamari ", "Dhaka", 5),
                          travelCard(urls[4], "The Westin", "Chittagong", 5),
                        ],
                      ),
                      
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
