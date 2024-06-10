// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// Widget Build(BuildContext conext){
//   imagecontroller _imagecontroller = Get.find();
//   return Scaffold(
//     body ListView.separated(
//       itemBuilder:(BuildContext context, int index){
//         return ClipRRect(
//           child:SizedBox(
//             height: 400,
//              width: 400,
//              child: FadeInImage()
//              image NetworkImage(_imagecontroller.allHotelImages[index]),
//              Placeholder: AssestImage("";)
//           )
//         );
//       }
//       separatorBuilder:(BuildContext context,int index){
//         return const Sizedbox(height:20);
//       }
//       itemCount: _imagecontroller.allHotelImages.length,
//     ),
//   );
// }