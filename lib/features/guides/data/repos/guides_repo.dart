import '../models/guide_model.dart';

/// Currently returns mock data. Replace getGuides() with ApiConsumer.get(...)
/// after the backend endpoint and response contract are confirmed.
class GuidesRepo {
  Future<List<GuideModel>> getGuides() async {
    await Future<void>.delayed(const Duration(milliseconds: 650));
    return _mockGuides;
  }

  // Temporary in-memory mock data. name and bio are not in the current API JSON.
  static const List<GuideModel> _mockGuides = [
    GuideModel(
      id: 1,
      userId: 'mock-user-001',
      name: 'Nikos Alexandrou',
      bio: 'Born and raised in Santorini. I enjoy sharing local history, culture, and the hidden stories behind the island.',
      location: 'Santorini, Greece',
      languages: 'English, Greek, French',
      specialties: 'Cultural History, Photography, Local Cuisine, Ancient Sites',
      isVerified: true,
      experienceYears: 8,
      happyTravelers: 284,
      averageRating: 4.9,
      reviewCount: 284,
      pricePerPerson: 85,
      profileImageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500',
      coverImageUrl: 'https://images.unsplash.com/photo-1533105079780-92b9be482077?w=1200',
    ),
    GuideModel(
      id: 2,
      userId: 'mock-user-002',
      name: 'Ayu Dewi',
      bio: 'I love introducing visitors to Bali’s local culture, spiritual heritage, and peaceful natural places.',
      location: 'Ubud, Bali',
      languages: 'English, Indonesian, Japanese',
      specialties: 'Spiritual Wellness, Local Culture, Nature',
      isVerified: true,
      experienceYears: 5,
      happyTravelers: 197,
      averageRating: 4.8,
      reviewCount: 197,
      pricePerPerson: 65,
      profileImageUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500',
      coverImageUrl: 'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=1200',
    ),
    GuideModel(
      id: 3,
      userId: 'mock-user-003',
      name: 'Marco Bellini',
      bio: 'A local guide who enjoys sharing Rome’s architecture, art, and lesser-known historical corners.',
      location: 'Rome, Italy',
      languages: 'English, Italian, Spanish',
      specialties: 'Art & Architecture, History, Local Culture',
      isVerified: false,
      experienceYears: 6,
      happyTravelers: 512,
      averageRating: 4.9,
      reviewCount: 512,
      pricePerPerson: 95,
      profileImageUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500',
      coverImageUrl: 'https://images.unsplash.com/photo-1515542622106-78bda8ba0e5b?w=1200',
    ),
    GuideModel(
      id: 4,
      userId: 'mock-user-004',
      name: 'Yuki Tanaka',
      bio: 'I help travelers discover Kyoto’s traditional culture, historic streets, and quiet local spots.',
      location: 'Kyoto, Japan',
      languages: 'Japanese, English',
      specialties: 'Traditional Culture, Ancient Sites, Local Cuisine',
      isVerified: true,
      experienceYears: 4,
      happyTravelers: 163,
      averageRating: 4.7,
      reviewCount: 163,
      pricePerPerson: 75,
      profileImageUrl: 'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=500',
      coverImageUrl: 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=1200',
    ),
  ];
}
