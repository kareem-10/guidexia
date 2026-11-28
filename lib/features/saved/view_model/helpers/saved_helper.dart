import 'package:tourist_app/features/explore/data/models/place_model.dart';
import 'package:tourist_app/features/guides/data/models/guide_model.dart';
import 'package:tourist_app/features/stays/data/models/stay_model.dart';
import 'package:tourist_app/features/saved/data/models/saved_model.dart';
import 'package:tourist_app/features/saved/view_model/cubit/saved_state.dart';

class SavedHelper {
  static String normalizeType(String entityType) {
    switch (entityType.toLowerCase()) {
      case 'place':
        return 'Place';
      case 'guide':
        return 'Guide';
      case 'stay':
      case 'accommodation':
        return 'Accommodation';
      default:
        return entityType;
    }
  }

  static bool isSaved({
    required List<SavedModel> saves,
    required String entityType,
    required int entityId,
  }) {
    final normalizedType = normalizeType(entityType);

    return saves.any(
      (save) =>
          normalizeType(save.entityType) == normalizedType &&
          save.entityId == entityId,
    );
  }

  static SavedSuccess buildSuccess({
    required List<SavedModel> saves,
    required List<PlaceModel> allPlaces,
    required List<GuideModel> allGuides,
    required List<StayModel> allStays,
  }) {
    return SavedSuccess(
      saves: List.unmodifiable(saves),
      places: allPlaces
          .where(
            (item) =>
                isSaved(saves: saves, entityType: 'Place', entityId: item.id),
          )
          .toList(),
      guides: allGuides
          .where(
            (item) =>
                isSaved(saves: saves, entityType: 'Guide', entityId: item.id),
          )
          .toList(),
      stays: allStays
          .where(
            (item) => isSaved(
              saves: saves,
              entityType: 'Accommodation',
              entityId: item.id,
            ),
          )
          .toList(),
    );
  }
}
