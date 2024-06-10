

import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140.0), // Adjust the height as needed
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 80.0), // Adjust the left and top padding as needed
            // child: IconButton(
            //   icon: Icon(Icons.arrow_back),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title "UserProfile"
            Text(
              'UserProfile',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // User Image
            const CircleAvatar(
              radius: 50,
              // Replace 'user_image_url' with the actual URL of the user's image
              backgroundImage: NetworkImage(
                  'https://scontent.fdac37-1.fna.fbcdn.net/v/t39.30808-6/367433991_6398403176923391_2436118984553061014_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeGtQktBnAcDBeFj2iz_vp7-fZBI93pboTl9kEj3eluhOTFuYW-KA-jE15DFkkpujrwkRpXx5dbmCHkvFIKEx6me&_nc_ohc=uGOoEGvsvYYAX_vUlsJ&_nc_ht=scontent.fdac37-1.fna&oh=00_AfDBSqW4A1cezzftLmCEeupqTghAx67_frLhe29S2htvmQ&oe=660498FE'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement edit profile functionality
              },
              child: const Text('Edit Profile'),
            ),
            const SizedBox(height: 20),
            // Personal Details
            const ListTile(
              title: Text('Name: John Doe'),
            ),
            const ListTile(
              title: Text('Username: johndoe123'),
            ),
            const ListTile(
              title: Text('Email: johndoe@example.com'),
            ),
            const ListTile(
              title: Text('Phone Number: +1234567890'),
            ),
            const SizedBox(height: 20), // Add some space before the logout button
            // Logout Button
            ElevatedButton(
              onPressed: () {
                // Implement logout functionality
              },
              child: const Text('Logout'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}



