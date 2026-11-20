import '../models/stay_model.dart';

class StayRepository {
  Future<List<StayModel>> getStays() async {
    await Future.delayed(const Duration(milliseconds: 900));

    return _mockStays
        .map((stay) => StayModel.fromJson(stay))
        .toList(growable: false);
  }

  static final List<Map<String, dynamic>> _mockStays = [
    {
      'id': 1,
      'name': 'Four Seasons Hotel Cairo at Nile Plaza',
      'description':
          'A luxury hotel overlooking the Nile River, offering elegant rooms, fine dining, and premium facilities.',
      'city': 'Cairo',
      'country': 'Egypt',
      'type': 'Luxury Hotel',
      'starRating': 5,
      'pricePerNight': 350.0,
      'currency': 'USD',
      'averageRating': 4.8,
      'reviewCount': 1250,
      'imageUrl':
          'https://images.unsplash.com/photo-1566073771259-6a8506099945',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1566073771259-6a8506099945',
      'websiteUrl': 'https://www.fourseasons.com/caironp/',
      'latitude': 30.0367,
      'longitude': 31.2315,
      'amenities': [
        'Free WiFi',
        'Swimming Pool',
        'Spa',
        'Restaurant',
        'Fitness Center',
      ],
      'rooms': [],
    },
    {
      'id': 2,
      'name': 'Steigenberger Cecil Hotel',
      'description':
          'A historic hotel located in the heart of Alexandria, close to the Mediterranean Sea and major attractions.',
      'city': 'Alexandria',
      'country': 'Egypt',
      'type': 'Historic Hotel',
      'starRating': 4,
      'pricePerNight': 120.0,
      'currency': 'USD',
      'averageRating': 4.5,
      'reviewCount': 850,
      'imageUrl': 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb',
      'websiteUrl': 'https://www.steigenberger.com/',
      'latitude': 31.2001,
      'longitude': 29.8942,
      'amenities': ['Free WiFi', 'Restaurant', 'Sea View', 'Room Service'],
      'rooms': [],
    },
    {
      'id': 3,
      'name': 'JAZ Aquamarine Resort',
      'description':
          'A beachfront resort in Hurghada featuring swimming pools, water activities, and relaxing accommodation.',
      'city': 'Hurghada',
      'country': 'Egypt',
      'type': 'Resort',
      'starRating': 5,
      'pricePerNight': 180.0,
      'currency': 'USD',
      'averageRating': 4.7,
      'reviewCount': 2100,
      'imageUrl':
          'https://images.unsplash.com/photo-1571896349842-33c89424de2d',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1571896349842-33c89424de2d',
      'websiteUrl': 'https://www.jazhotels.com/',
      'latitude': 27.0876,
      'longitude': 33.8365,
      'amenities': [
        'Free WiFi',
        'Swimming Pool',
        'Private Beach',
        'Restaurant',
        'Water Activities',
      ],
      'rooms': [],
    },
    {
      'id': 4,
      'name': 'Hilton Luxor Resort & Spa',
      'description':
          'A beautiful riverside resort offering stunning Nile views, luxury accommodation, and spa facilities.',
      'city': 'Luxor',
      'country': 'Egypt',
      'type': 'Resort',
      'starRating': 5,
      'pricePerNight': 220.0,
      'currency': 'USD',
      'averageRating': 4.8,
      'reviewCount': 980,
      'imageUrl':
          'https://images.unsplash.com/photo-1564501049412-61c2a3083791',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1564501049412-61c2a3083791',
      'websiteUrl': 'https://www.hilton.com/',
      'latitude': 25.6872,
      'longitude': 32.6396,
      'amenities': [
        'Free WiFi',
        'Swimming Pool',
        'Spa',
        'Nile View',
        'Restaurant',
      ],
      'rooms': [],
    },
    {
      'id': 5,
      'name': 'Rixos Premium Seagate',
      'description':
          'An upscale beachfront resort in Sharm El Sheikh with premium facilities, multiple pools, and private beach access.',
      'city': 'Sharm El Sheikh',
      'country': 'Egypt',
      'type': 'Luxury Resort',
      'starRating': 5,
      'pricePerNight': 250.0,
      'currency': 'USD',
      'averageRating': 4.9,
      'reviewCount': 1750,
      'imageUrl':
          'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b',
      'websiteUrl': 'https://www.rixos.com/',
      'latitude': 28.0386,
      'longitude': 34.4371,
      'amenities': [
        'Free WiFi',
        'Swimming Pool',
        'Private Beach',
        'Spa',
        'Restaurants',
      ],
      'rooms': [],
    },
  ];
}
