

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'details.dart';
import 'hotel_model.dart';

class HotelListScreen extends StatelessWidget {
  final String? location;
  final String fromDate;
  final String toDate;
  final int roomQuantity;
  final int guestNumber;

  const HotelListScreen({
    required this.location,
    required this.fromDate,
    required this.toDate,
    required this.roomQuantity,
    required this.guestNumber,
    Key? key,
  }) : super(key: key);

  Future<List<HotelModel>> queryAllHotels() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('hotels')
          .where('location', isEqualTo: location)
          .get();

      List<HotelModel> hotels = [];
      for (DocumentSnapshot document in querySnapshot.docs) {
        hotels.add(HotelModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return hotels;
    } catch (error) {
      print('Error fetching hotels: $error');
      return []; // Return an empty list in case of an error
    }
  }

 Future<List<String>> queryHotelPhotos(String location, String id) async {
    try {
      QuerySnapshot hotelSnapshot = await FirebaseFirestore.instance
          .collection('hotels')
          .where('location', isEqualTo: location)
          .where('id', isEqualTo: id)
          .get();

      if (hotelSnapshot.docs.isNotEmpty) {
        DocumentSnapshot hotelDocument = hotelSnapshot.docs.first;
        Map<String, dynamic>? data =
            hotelDocument.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('url')) {
          dynamic photoUrlsData = data['url'];

          List<String> photoUrls = [];
          if (photoUrlsData is String) {
            photoUrls =
                photoUrlsData.split(',').map((url) => url.trim()).toList();
          } else if (photoUrlsData is List<dynamic>) {
            photoUrls = List<String>.from(photoUrlsData);
          }

          return photoUrls;
        } else {
          print(
              'No photoUrls found in the hotel document with location $location and hotel ID $id.');
          return [];
        }
      } else {
        print(
            'No hotel document found with location $location and hotel ID $id.');
        return [];
      }
    } catch (error, stackTrace) {
      print('Error fetching hotel photos: $error');
      print('StackTrace: $stackTrace');
      return [];
    }
  }





  void navigateToHotelDetail(BuildContext context, HotelModel hotel) {
    DateTime start = DateTime.parse(fromDate);
    DateTime end = DateTime.parse(toDate);
    int numberOfDays = end.difference(start).inDays;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HotelDetails(
          hotel: hotel,
          fromDate: fromDate,
          toDate: toDate,
          roomQuantity: roomQuantity,
          guestNumber: guestNumber,
          numberOfDays: numberOfDays,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          title: Text(
            'Hotels in ${location ?? "Unknown Location"}',
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: 'RaleWay',
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 62, 112),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: FutureBuilder<List<HotelModel>>(
        future: queryAllHotels(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching hotels. Please try again later.'),
            );
          }
          final hotels = snapshot.data ?? [];
          return SingleChildScrollView(
  child: Column(
    children: hotels.map((hotel) {
      return FutureBuilder<List<String>>(
       future: queryHotelPhotos(hotel.location, hotel.id), // Pass the hotel ID here
        builder: (context, photoSnapshot) {
          if (photoSnapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (photoSnapshot.hasError) {
            return const Text('Error fetching hotel photos.');
          }
          final photoUrls = photoSnapshot.data ?? [];
          return GestureDetector(
            onTap: () {
              navigateToHotelDetail(context, hotel);
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 400,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: photoUrls.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            photoUrls[index],
                            height: 500,
                            width: 450,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      '${hotel.name}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                hotel.location,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              '${hotel.rating} ⭐',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          hotel.address ?? 'Unknown Address',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tk.${hotel.price.toString()}',
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'For 1 night',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Amenities: ${hotel.amenities}',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }).toList(),
  ),
);

        },
      ),
    );
  }
}
