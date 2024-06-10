// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// import 'hotel_model.dart';
// import 'ssl.dart';


// class HotelDetails extends StatelessWidget {
//   final HotelModel hotel;
//   final String fromDate;
//   final String toDate;
//   final int roomQuantity;
//   final int guestNumber;
//   final int numberOfDays;

//   const HotelDetails({
//     required this.hotel,
//     required this.fromDate,
//     required this.toDate,
//     required this.roomQuantity,
//     required this.guestNumber,
//     required this.numberOfDays,
//     Key? key,
//   }) : super(key: key);

  
//   Future<List<String>> queryHotelPhotos(String location, String id) async {
//     try {
//       QuerySnapshot hotelSnapshot = await FirebaseFirestore.instance
//           .collection('hotels')
//           .where('location', isEqualTo: location)
//           .where('id', isEqualTo: id)
//           .get();

//       if (hotelSnapshot.docs.isNotEmpty) {
//         DocumentSnapshot hotelDocument = hotelSnapshot.docs.first;
//         Map<String, dynamic>? data =
//             hotelDocument.data() as Map<String, dynamic>?;

//         if (data != null && data.containsKey('url')) {
//           dynamic photoUrlsData = data['url'];

//           List<String> photoUrls = [];
//           if (photoUrlsData is String) {
//             photoUrls =
//                 photoUrlsData.split(',').map((url) => url.trim()).toList();
//           } else if (photoUrlsData is List<dynamic>) {
//             photoUrls = List<String>.from(photoUrlsData);
//           }

//           return photoUrls;
//         } else {
//           print(
//               'No photoUrls found in the hotel document with location $location and hotel ID $id.');
//           return [];
//         }
//       } else {
//         print(
//             'No hotel document found with location $location and hotel ID $id.');
//         return [];
//       }
//     } catch (error, stackTrace) {
//       print('Error fetching hotel photos: $error');
//       print('StackTrace: $stackTrace');
//       return [];
//     }
//   }

//   double calculateTotalPrice() {
//     double basePrice = hotel.price.toDouble() * numberOfDays;
//     double totalPrice = basePrice * roomQuantity;
//     return totalPrice;
//   }


//   @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     backgroundColor: Colors.white,
//     body: Column(
//       children: [
//         Expanded(
//           flex: 2,
//           child: FutureBuilder<List<String>>(
//             future: queryHotelPhotos(hotel.location, hotel.id),
//             builder: (context, photoSnapshot) {
//               if (photoSnapshot.connectionState ==
//                   ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//               if (photoSnapshot.hasError) {
//                 print(
//                     'Error fetching hotel photos: ${photoSnapshot.error}');
//                 return const Text('Error fetching hotel photos.');
//               }
//               final photoUrls = photoSnapshot.data ?? [];
//               return photoUrls.isNotEmpty
//                   ? Image.network(photoUrls.first, fit: BoxFit.cover)
//                   : const Placeholder();
//             },
//           ),
//         ),
//         Flexible(
//           flex: 3,
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                   vertical: 16.0, horizontal: 24.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: kToolbarHeight),
//                   Text(
//                     hotel.name,
//                     style: const TextStyle(
//                       color: Colors.black,
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8.0),
//                   Row(
//                     children: [
//                       Text(
//                         '${hotel.rating} ⭐',
//                         style: const TextStyle(
//                           color: Color.fromARGB(255, 2, 2, 2),
//                           fontSize: 12.0,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16.0),
//                   Text(
//                     hotel.address ?? 'Unknown Address',
//                     style: const TextStyle(
//                       color: Colors.grey,
//                       fontSize: 16.0,
//                     ),
//                   ),
//                   const SizedBox(height: 16.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Tk.${hotel.price.toString()}',
//                         style: const TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20.0,
//                         ),
//                       ),
//                       const Text(
//                         "/per night",
//                         style: TextStyle(
//                           fontSize: 12.0,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24.0),
//                   const Text(
//                     "DESCRIPTION",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 14.0,
//                     ),
//                   ),
//                   const SizedBox(height: 10.0),
//                   const Text(
//                     "The Hotel is a luxurious 5-star hotel located in the heart of the city, offering unparalleled elegance and comfort to discerning travelers. Nestled amidst lush greenery, our hotel boasts breathtaking views of the city skyline and the surrounding landscape."

//                     "Each of our exquisitely designed rooms and suites features modern amenities and elegant furnishings, ensuring a comfortable and memorable stay for our guests. From spacious king-size beds to state-of-the-art entertainment systems, we have thoughtfully curated every detail to cater to your every need."

//                     "Indulge your taste buds at our award-winning restaurants, where world-class chefs prepare a tantalizing array of culinary delights, ranging from authentic local cuisine to international favorites. After a day of exploration, unwind and rejuvenate at our luxurious spa, where a range of therapeutic treatments and wellness therapies await you."

//                     "Whether you're traveling for business or leisure, The Grand Hotel offers an unparalleled experience that will exceed your expectations. Come, experience true luxury and hospitality at The  Hotel, where every moment is crafted with care and attention to detail.",
//                     textAlign: TextAlign.justify,
//                     style: TextStyle(
//                       fontWeight: FontWeight.w300,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 24.0),
//                   Row(
//                     children: [
//                       const Text(
//                     "Facilities:",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 14.0,
//                     ),
//                   ),
//                       Text(
//                         '${hotel.amenities} ',
//                         style: const TextStyle(
//                           color: Color.fromARGB(255, 2, 2, 2),
//                           fontSize: 12.0,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Total Price:',
//                         style: TextStyle(
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         'For $numberOfDays  TK.${calculateTotalPrice().toStringAsFixed(2)}',
//                         style: const TextStyle(
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24.0),
//                   ElevatedButton(
//                     onPressed: () {
//                       double totalPrice = calculateTotalPrice();

//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => MyPay(totalPrice: totalPrice,),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: Colors.blue[900],
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 16.0,
//                         horizontal: 32.0,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                     child: const Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(
//                           Icons.book,
//                           color: Colors.white,
//                         ),
//                         SizedBox(width: 8.0),
//                         Text(
//                           "Book Now",
//                           style: TextStyle(
//                             fontSize: 16.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'hotel_model.dart';
import 'ssl.dart';

class HotelDetails extends StatelessWidget {
  final HotelModel hotel;
  final String fromDate;
  final String toDate;
  final int roomQuantity;
  final int guestNumber;
  final int numberOfDays;

  const HotelDetails({
    required this.hotel,
    required this.fromDate,
    required this.toDate,
    required this.roomQuantity,
    required this.guestNumber,
    required this.numberOfDays,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: FutureBuilder<List<String>>(
              future: queryHotelPhotos(hotel.location, hotel.id),
              builder: (context, photoSnapshot) {
                if (photoSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (photoSnapshot.hasError) {
                  print('Error fetching hotel photos: ${photoSnapshot.error}');
                  return const Text('Error fetching hotel photos.');
                }
                final photoUrls = photoSnapshot.data ?? [];
                return photoUrls.isNotEmpty
                    ? Image.network(photoUrls.first, fit: BoxFit.cover)
                    : const Placeholder();
              },
            ),
          ),
          Flexible(
            flex: 3,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: kToolbarHeight),
                  Text(
                    hotel.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text(
                        '${hotel.rating} ⭐',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 2, 2, 2),
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    hotel.address ?? 'Unknown Address',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tk.${hotel.price.toString()}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      const Text(
                        '/per night',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  const Text(
                    "DESCRIPTION",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    "The Hotel is a luxurious 5-star hotel located in the heart of the city, offering unparalleled elegance and comfort to discerning travelers. Nestled amidst lush greenery, our hotel boasts breathtaking views of the city skyline and the surrounding landscape."

                    "Each of our exquisitely designed rooms and suites features modern amenities and elegant furnishings, ensuring a comfortable and memorable stay for our guests. From spacious king-size beds to state-of-the-art entertainment systems, we have thoughtfully curated every detail to cater to your every need."

                    "Indulge your taste buds at our award-winning restaurants, where world-class chefs prepare a tantalizing array of culinary delights, ranging from authentic local cuisine to international favorites. After a day of exploration, unwind and rejuvenate at our luxurious spa, where a range of therapeutic treatments and wellness therapies await you."

                    "Whether you're traveling for business or leisure, The Grand Hotel offers an unparalleled experience that will exceed your expectations. Come, experience true luxury and hospitality at The  Hotel, where every moment is crafted with care and attention to detail.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    children: [
                      const Text(
                        "Facilities:",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        '${hotel.amenities} ',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 2, 2, 2),
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Price:',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'For $numberOfDays  TK.${calculateTotalPrice().toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      double totalPrice = calculateTotalPrice();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyPay(
                            hotel: hotel,
                            fromDate: fromDate,
                            toDate: toDate,
                            totalPrice: totalPrice,                          
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue[900],
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 32.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.book,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          "Book Now",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
        Map<String, dynamic>? data = hotelDocument.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('url')) {
          dynamic photoUrlsData = data['url'];

          List<String> photoUrls = [];
          if (photoUrlsData is String) {
            photoUrls = photoUrlsData.split(',').map((url) => url.trim()).toList();
          } else if (photoUrlsData is List<dynamic>) {
            photoUrls = List<String>.from(photoUrlsData);
          }

          return photoUrls;
        } else {
          print('No photoUrls found in the hotel document with location $location and hotel ID $id.');
          return [];
        }
      } else {
        print('No hotel document found with location $location and hotel ID $id.');
        return [];
      }
    } catch (error, stackTrace) {
      print('Error fetching hotel photos: $error');
      print('StackTrace: $stackTrace');
      return [];
    }
  }

  double calculateTotalPrice() {
    double basePrice = hotel.price.toDouble() * numberOfDays;
    double totalPrice = basePrice * roomQuantity;
    return totalPrice;
  }
}
