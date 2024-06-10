// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class Booking extends StatelessWidget {
//   const Booking({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('             Booking Details'),
//       ),
//       body: const BookingBody(),
//     );
//   }
// }

// class BookingBody extends StatelessWidget {
//   const BookingBody({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('payments').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return const Center(child: Text('Error fetching data'));
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('No bookings found'));
//           }

//           final bookingDocs = snapshot.data!.docs;

//           return ListView.builder(
//             itemCount: bookingDocs.length,
//             itemBuilder: (context, index) {
//               final bookingData = bookingDocs[index].data() as Map<String, dynamic>;
//               final hotel = bookingData['hotel'] as Map<String, dynamic>;

//               return Card(
//                 margin: const EdgeInsets.all(10),
//                 child: ListTile(
//                   title: Text(hotel['name']),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Location: ${hotel['location']}'),
//                       Text('Address: ${hotel['address']}'),
//                       Text('Amenities: ${hotel['amenities']}'),
//                       Text('From: ${bookingData['fromDate']}'),
//                       Text('To: ${bookingData['toDate']}'),
//                       Text('Total Price: ${bookingData['totalPrice']} BDT'),
//                     ],
//                   ),
//                   trailing: Image.network(
//                     hotel['photoUrls'][0],
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Booking extends StatelessWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('        Booking Details'),
      ),
      body: const BookingBody(),
    );
  }
}

class BookingBody extends StatelessWidget {
  const BookingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('payments').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No bookings found'));
          }

          final bookingDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: bookingDocs.length,
            itemBuilder: (context, index) {
              final bookingData = bookingDocs[index].data() as Map<String, dynamic>;
              final hotel = bookingData['hotel'] as Map<String, dynamic>;
              final photoUrls = List<String>.from(hotel['photoUrls'] ?? []);

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(hotel['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Location: ${hotel['location']}'),
                      Text('Address: ${hotel['address']}'),
                      Text('Amenities: ${hotel['amenities']}'),
                      Text('From: ${bookingData['fromDate']}'),
                      Text('To: ${bookingData['toDate']}'),
                      Text('Total Price: ${bookingData['totalPrice']} BDT'),
                    ],
                  ),
                  trailing: photoUrls.isNotEmpty
                      ? Image.network(
                          photoUrls[0],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : const SizedBox(
                          width: 50,
                          height: 50,
                          child: Center(child: Text('No Image')),
                        ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
