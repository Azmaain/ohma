
// class HotelModel {
//   final String id;
//   final String name;
//   final String location;
//   final String address;
//   final double rating;
//   final int price;
//   final String amenities;
//   final List<String> photoUrls; // Add this field

//   HotelModel({
//     required this.id,
//     required this.name,
//     required this.location,
//     required this.address,
//     required this.rating,
//     required this.price,
//     required this.amenities,
//     required this.photoUrls,
//   });

//   factory HotelModel.fromMap(Map<String, dynamic> map) {
//     final photosData = (map['photos'] as Map<String, dynamic>?) ?? {};
//     final List<String> photoUrls = photosData.values
//         .map<String>((photo) => photo['url'] as String)
//         .toList();

//     return HotelModel(
//       id: map['id'] as String? ?? '',
//       name: map['name'] as String? ?? '',
//       location: map['location'] as String? ?? '',
//       address: map['address'] as String? ?? '',
//       rating: double.tryParse(map['rating'] as String? ?? '') ?? 0.0,
//       price: map['price'] as int? ?? 0,
//       amenities: map['amenities'] as String? ?? '',
//       photoUrls: photoUrls,
//     );
//   }
// }


class HotelModel {
  final String id;
  final String name;
  final String location;
  final String address;
  final double rating;
  final int price;
  final String amenities;
  final List<String> photoUrls;

  HotelModel({
    required this.id,
    required this.name,
    required this.location,
    required this.address,
    required this.rating,
    required this.price,
    required this.amenities,
    required this.photoUrls,
  });

  factory HotelModel.fromMap(Map<String, dynamic> map) {
    final photosData = (map['photos'] as Map<String, dynamic>?) ?? {};
    final List<String> photoUrls = photosData.values
        .map<String>((photo) => photo['url'] as String)
        .toList();

    return HotelModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      location: map['location'] as String? ?? '',
      address: map['address'] as String? ?? '',
      rating: double.tryParse(map['rating'] as String? ?? '') ?? 0.0,
      price: map['price'] as int? ?? 0,
      amenities: map['amenities'] as String? ?? '',
      photoUrls: photoUrls,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'address': address,
      'rating': rating,
      'price': price,
      'amenities': amenities,
      'photoUrls': photoUrls,
    };
  }
}
