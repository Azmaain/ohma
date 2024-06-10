import 'package:demo_project/screens/pages/favourites/favourites.dart';
import 'package:flutter/material.dart';


class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('User'),
              accountEmail: const Text('user@gmail.com'),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://assets-global.website-files.com/645cf73a1399f9f6ed09a0e8/645cf73a1399f900e009a8cc_Hero-Wide-SaintMartin-SintMaarten-p-1600.jpeg',
                  ),
                  fit: BoxFit.cover,
                ),
                color: Colors.blue,
              ),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network(
                    'https://scontent.fdac37-1.fna.fbcdn.net/v/t39.30808-6/367433991_6398403176923391_2436118984553061014_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeGtQktBnAcDBeFj2iz_vp7-fZBI93pboTl9kEj3eluhOTFuYW-KA-jE15DFkkpujrwkRpXx5dbmCHkvFIKEx6me&_nc_ohc=uGOoEGvsvYYAX_vUlsJ&_nc_ht=scontent.fdac37-1.fna&oh=00_AfDBSqW4A1cezzftLmCEeupqTghAx67_frLhe29S2htvmQ&oe=660498FE',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag, color: Colors.black),
              title: const Text("My Bookings"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const favourites()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.support, color: Colors.black),
              title: const Text("Support"),
              onTap: () {
                // Navigate to Support page
              },
            ),
            ListTile(
              leading: const Icon(Icons.star, color: Colors.black),
              title: const Text("Rate Us"),
              onTap: () {
                // Navigate to Rate Us page
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.black),
              title: const Text("Saved"),
              onTap: () {
                // Navigate to Saved page
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.hotel, color: Colors.black),
              title: const Text("Hotel"),
              onTap: () {
                // Navigate to Hotel page
              },
            ),
            ListTile(
              leading: const Icon(Icons.flight, color: Colors.black),
              title: const Text("Flight"),
              onTap: () {
                // Navigate to Flight page
              },
            ),
            ListTile(
              leading: const Icon( Icons.car_rental, color: Colors.black),
              title: const Text("Car"),
              onTap: () {
                // Navigate to Car page
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.black),
              title: const Text("Logout"),
              onTap: () {
                // Perform logout action
              },
            ),
          ],
        ),
      ),
    );
  }
}
