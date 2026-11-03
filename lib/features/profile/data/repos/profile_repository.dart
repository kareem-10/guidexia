import '../models/profile_model.dart';

class ProfileRepository {
  Future<ProfileModel> getProfile() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return const ProfileModel(
      name: 'Alex Morgan',
      email: 'alex.morgan@example.com',
      phone: '+20 100 123 4567',
      country: 'Egypt',
      city: 'Alexandria',
      role: 'Tourist',
      imageUrl: null,
    );
  }

  Future<List<TripModel>> getTrips() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return const [
      TripModel(
        title: 'A Day in Ancient Cairo',
        location: 'Cairo, Egypt',
        date: 'Oct 28, 2026',
        status: 'Upcoming',
        imageUrl:
            'https://images.unsplash.com/photo-1572252009286-268acec5ca0a?w=900',
      ),
      TripModel(
        title: 'Alexandria Seaside',
        location: 'Alexandria, Egypt',
        date: 'Sep 12, 2026',
        status: 'Completed',
        imageUrl:
            'https://images.unsplash.com/photo-1568322445389-f64ac2515020?w=900',
      ),
    ];
  }

  Future<List<ReviewModel>> getReviews() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return const [
      ReviewModel(
        placeName: 'Bibliotheca Alexandrina',
        comment: 'A beautiful place with so much history.',
        rating: 5,
        date: 'Oct 10, 2026',
        imageUrl:
            'https://images.unsplash.com/photo-1568322445389-f64ac2515020?w=900',
      ),
      ReviewModel(
        placeName: 'Citadel of Qaitbay',
        comment: 'Amazing sea views and a great experience.',
        rating: 4.5,
        date: 'Sep 18, 2026',
        imageUrl:
            'https://images.unsplash.com/photo-1539650116574-75c0c6d73f6e?w=900',
      ),
    ];
  }
}
