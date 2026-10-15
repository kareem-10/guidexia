import '../models/stay_model.dart';

class StayRepository {
  // Temporary mock data until the backend API is ready.
  Future<List<StayModel>> getStays() async {
    await Future.delayed(const Duration(milliseconds: 900));

    return _mockStays.map(StayModel.fromJson).toList(growable: false);
  }

  static final List<Map<String, dynamic>> _mockStays = [
    {
      'id': 1,
      'name': 'Canaves Oia Epitome',
      'description':
          'A luxury stay with beautiful architecture and a swimming pool.',
      'city': 'Oia',
      'country': 'Greece',
      'type': 'Resort',
      'starRating': 5,
      'pricePerNight': 480.0,
      'currency': 'EUR',
      'averageRating': 4.9,
      'reviewCount': 320,
      'imageUrl':
          'https://images.unsplash.com/photo-1571896349842-33c89424de2d',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1571896349842-33c89424de2d',
      'websiteUrl': 'https://www.canaves.com/',
      'latitude': 36.4618,
      'longitude': 25.3753,
      'amenities': ['Free WiFi', 'Pool'],
      'rooms': [],
    },
    {
      'id': 2,
      'name': 'Seaside Boutique Hotel',
      'description': 'A comfortable boutique stay close to the sea.',
      'city': 'Santorini',
      'country': 'Greece',
      'type': 'Boutique Hotel',
      'starRating': 4,
      'pricePerNight': 220.0,
      'currency': 'EUR',
      'averageRating': 4.7,
      'reviewCount': 185,
      'imageUrl':
          'https://images.unsplash.com/photo-1566073771259-6a8506099945',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1566073771259-6a8506099945',
      'websiteUrl': 'https://example.com/',
      'latitude': 36.3932,
      'longitude': 25.4615,
      'amenities': ['Free WiFi', 'Pool'],
      'rooms': [],
    },
    {
      'id': 3,
      'name': 'Aegean View Hotel',
      'description': 'A relaxing hotel with views of the Aegean Sea.',
      'city': 'Fira',
      'country': 'Greece',
      'type': 'Hotel',
      'starRating': 4,
      'pricePerNight': 165.0,
      'currency': 'EUR',
      'averageRating': 4.5,
      'reviewCount': 96,
      'imageUrl': 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb',
      'websiteUrl': 'https://example.com/',
      'latitude': 36.4167,
      'longitude': 25.4333,
      'amenities': ['Free WiFi'],
      'rooms': [],
    },
  ];
}
