

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_project/screens/pages/Hotelinfo/hotel_model.dart';
import 'package:demo_project/screens/pages/homepage/components/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum SdkType { TESTBOX, LIVE }

class MyPay extends StatefulWidget {
  final double totalPrice;
  final HotelModel hotel;
  final String fromDate;
  final String toDate;

  MyPay({
    required this.totalPrice, 
    required this.hotel, 
    required this.fromDate, 
    required this.toDate,
    Key? key,
    }): super(key: key);

  @override
  _MyPayState createState() => _MyPayState();
}

class _MyPayState extends State<MyPay> {
  late SdkType _sdkType;

  @override
  void initState() {
    super.initState();
    _sdkType = SdkType.TESTBOX; // Default to TESTBOX
  }

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Payment'),
        automaticallyImplyLeading: true, // Show back button automatically
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                initiatePayment();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 2, 64, 114),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 3,
              ),
              child: const Text(
                'Pay Now',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> initiatePayment() async {
    String storeId = 'niloy6616f30528c00';
    String storePassword = 'niloy6616f30528c00@ssl';

    SSLCommerzInitialization initialization = SSLCommerzInitialization(
      currency: SSLCurrencyType.BDT,
      sdkType: _sdkType == SdkType.TESTBOX ? SSLCSdkType.TESTBOX : SSLCSdkType.LIVE,
      store_id: storeId,
      store_passwd: storePassword,
      total_amount: widget.totalPrice,
      tran_id: DateTime.now().millisecondsSinceEpoch.toString(), product_category: 'Hotel',
    );

    Sslcommerz sslcommerz = Sslcommerz(initializer: initialization);

    try {
      var result = await sslcommerz.payNow();

      if (result.status!.toLowerCase() == "failed") {
        Fluttertoast.showToast(
          msg: "Transaction failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } else {
        await FirebaseFirestore.instance.collection('payments').add({
        'totalPrice': widget.totalPrice,
        'hotel': widget.hotel.toJson(), // Ensure your HotelModel has a toJson method
        'fromDate': widget.fromDate,
        'toDate': widget.toDate,
        'transactionId': result.tranId,
        'status': result.status,
      });
        Fluttertoast.showToast(
          msg: "Transaction successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          
        );
        Navigator.pushReplacementNamed(context, GoBooking.routeName); 
      }
    } catch (e) {
      debugPrint("Payment Error: $e");
      Fluttertoast.showToast(
        msg: "Payment Error: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
// import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
// import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
// import 'package:flutter_sslcommerz/sslcommerz.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// enum SdkType { TESTBOX, LIVE }

// class MyPay extends StatefulWidget {
//   final double totalPrice;

//   MyPay({required this.totalPrice});

//   @override
//   _MyPayState createState() => _MyPayState();
// }

// class _MyPayState extends State<MyPay> {
//   late SdkType _sdkType;
//   String _transactionStatus = '';

//   @override
//   void initState() {
//     super.initState();
//     _sdkType = SdkType.TESTBOX; // Default to TESTBOX
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text('Payment'),
//         automaticallyImplyLeading: true, // Show back button automatically
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 40),
//             ElevatedButton(
//               onPressed: () {
//                 initiatePayment();
//               },
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.white,
//                 backgroundColor: const Color.fromARGB(255, 2, 64, 114),
//                 padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 elevation: 3,
//               ),
//               child: const Text(
//                 'Pay Now',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               _transactionStatus,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: _transactionStatus.contains('successful') ? Colors.green : Colors.red,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> initiatePayment() async {
//     String storeId = 'niloy6616f30528c00';
//     String storePassword = 'niloy6616f30528c00@ssl';

//     SSLCommerzInitialization initialization = SSLCommerzInitialization(
//       currency: SSLCurrencyType.BDT,
//       sdkType: _sdkType == SdkType.TESTBOX ? SSLCSdkType.TESTBOX : SSLCSdkType.LIVE,
//       store_id: storeId,
//       store_passwd: storePassword,
//       total_amount: widget.totalPrice,
//       tran_id: DateTime.now().millisecondsSinceEpoch.toString(),
//       product_category: 'Hotel',
//     );

//     Sslcommerz sslcommerz = Sslcommerz(initializer: initialization);

//    try {
//     var result = await sslcommerz.payNow();

//     if (result.status!.toLowerCase() == "success") {
//       // Payment successful, fetch hotel details from Firestore
//       DocumentSnapshot hotelSnapshot = await FirebaseFirestore.instance
//           .collection('hotels')
//           .doc('hotel_id') // Replace 'hotel_id' with your actual document ID
//           .get();

//       if (hotelSnapshot.exists) {
//         String hotelName = hotelSnapshot['name'];
       
//         double totalPrice = hotelSnapshot['price'];
//         String location = hotelSnapshot['location'];
//         List<String> images = List<String>.from(hotelSnapshot['images']);

//         // Navigate to BookingPage with retrieved hotel details
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => BookingPage(
//               hotelName: hotelName,
             
//               totalPrice: totalPrice,
//               location: location,
//               images: images,
//             ),
//           ),
//         );
//       } else {
//         Fluttertoast.showToast(
//           msg: "Hotel not found",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//         );
//       }
//     } else {
//       // Handle failed transaction
//       Fluttertoast.showToast(
//         msg: "Transaction failed",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//       );
//     }
//   } catch (e) {
//     // Handle payment error
//     debugPrint("Payment Error: $e");
//     Fluttertoast.showToast(
//       msg: "Payment Error: $e",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//     );
//   }
//   }
// }

