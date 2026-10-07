import 'package:tourist_app/features/explore/data/models/place_model.dart';

class ExploreRepo {
  Future<List<PlaceModel>> getPlaces({String? category, String? search}) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final places = [
      const PlaceModel(
        id: 1,
        name: 'Amalfi Coast',
        description:
            'A breathtaking coastal destination famous for its dramatic cliffs, beautiful villages and stunning sea views.',
        city: 'Amalfi',
        country: 'Italy',
        category: 'CoastalEscape',
        entryFee: 0,
        imageUrl:
            'https://images.unsplash.com/photo-1533105079780-92b9be482077',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1533105079780-92b9be482077',
        tags: ['Sea', 'Relaxing', 'Nature'],
        averageRating: 4.9,
        reviewCount: 324,
        isFeatured: true,
        latitude: 40.6333,
        longitude: 14.6029,
      ),

      const PlaceModel(
        id: 2,
        name: 'Venice',
        description:
            'A romantic city built around canals, historic architecture and unforgettable Italian culture.',
        city: 'Venice',
        country: 'Italy',
        category: 'Leisure',
        entryFee: 0,
        imageUrl:
            'https://images.unsplash.com/photo-1523906834658-6e24ef2386f9',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1523906834658-6e24ef2386f9',
        tags: ['Canals', 'Culture', 'Romantic'],
        averageRating: 4.8,
        reviewCount: 287,
        isFeatured: true,
        latitude: 45.4408,
        longitude: 12.3155,
      ),

      const PlaceModel(
        id: 3,
        name: 'Rome',
        description:
            'Discover ancient history, iconic landmarks and the rich culture of one of the world’s most famous cities.',
        city: 'Rome',
        country: 'Italy',
        category: 'Cultural',
        entryFee: 0,
        imageUrl: 'https://images.unsplash.com/photo-1552832230-c0197dd311b5',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1552832230-c0197dd311b5',
        tags: ['History', 'Culture', 'Architecture'],
        averageRating: 4.9,
        reviewCount: 451,
        isFeatured: true,
        latitude: 41.9028,
        longitude: 12.4964,
      ),

      const PlaceModel(
        id: 4,
        name: 'Santorini',
        description:
            'A beautiful Greek island known for its white buildings, blue domes and spectacular sunsets.',
        city: 'Santorini',
        country: 'Greece',
        category: 'Island',
        entryFee: 0,
        imageUrl:
            'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff',
        tags: ['Island', 'Sea', 'Sunset'],
        averageRating: 4.8,
        reviewCount: 391,
        isFeatured: true,
        latitude: 36.3932,
        longitude: 25.4615,
      ),

      const PlaceModel(
        id: 5,
        name: 'Hurghada',
        description:
            'A popular Egyptian Red Sea destination offering beautiful beaches, crystal clear water and amazing marine life.',
        city: 'Hurghada',
        country: 'Egypt',
        category: 'Beaches',
        entryFee: 100,
        imageUrl: 'https://images.unsplash.com/photo-1548013146-72479768bada',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1548013146-72479768bada',
        tags: ['Beach', 'Sea', 'Diving'],
        averageRating: 4.7,
        reviewCount: 218,
        isFeatured: true,
        latitude: 27.2579,
        longitude: 33.8116,
      ),

      const PlaceModel(
        id: 6,
        name: 'Luxor',
        description:
            'Explore the ancient Egyptian civilization through temples, monuments and archaeological treasures.',
        city: 'Luxor',
        country: 'Egypt',
        category: 'Historic',
        entryFee: 200,
        imageUrl:
            'https://images.unsplash.com/photo-1568322445389-f64c2c1e2b2c',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1568322445389-f64c2c1e2b2c',
        tags: ['History', 'Temples', 'Ancient Egypt'],
        averageRating: 4.9,
        reviewCount: 512,
        isFeatured: true,
        latitude: 25.6872,
        longitude: 32.6396,
      ),

      const PlaceModel(
        id: 7,
        name: 'Sharm El Sheikh',
        description:
            'A world-famous Red Sea destination known for its beaches, coral reefs and unforgettable diving experiences.',
        city: 'Sharm El Sheikh',
        country: 'Egypt',
        category: 'Beaches',
        entryFee: 150,
        imageUrl:
            'https://images.unsplash.com/photo-1539650116574-75c0c6d73f6e',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1539650116574-75c0c6d73f6e',
        tags: ['Beach', 'Diving', 'Sea'],
        averageRating: 4.8,
        reviewCount: 342,
        isFeatured: true,
        latitude: 27.9158,
        longitude: 34.3300,
      ),

      const PlaceModel(
        id: 8,
        name: 'Cairo',
        description:
            'The vibrant capital of Egypt, home to ancient landmarks, museums and the legendary pyramids.',
        city: 'Cairo',
        country: 'Egypt',
        category: 'Cultural',
        entryFee: 150,
        imageUrl:
            'https://images.unsplash.com/photo-1572252009286-268acec5ca0a',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1572252009286-268acec5ca0a',
        tags: ['Culture', 'History', 'City'],
        averageRating: 4.6,
        reviewCount: 629,
        isFeatured: false,
        latitude: 30.0444,
        longitude: 31.2357,
      ),
    ];

    var result = places;

    if (category != null) {
      result = result
          .where(
            (place) => place.category.toLowerCase() == category.toLowerCase(),
          )
          .toList();
    }

    if (search != null && search.trim().isNotEmpty) {
      final query = search.toLowerCase().trim();

      result = result.where((place) {
        return place.name.toLowerCase().contains(query) ||
            place.city.toLowerCase().contains(query) ||
            place.country.toLowerCase().contains(query);
      }).toList();
    }

    return result;
  }
}
