import 'package:tourist_app/features/saved/data/models/saved_model.dart';

class SavedRepository {
  final List<SavedModel> _saves = [];
  int _nextId = 1;

  Future<List<SavedModel>> getSaves({String? entityType}) async {
    if (entityType == null) {
      return List.unmodifiable(_saves);
    }

    return _saves
        .where(
          (favorite) =>
              favorite.entityType.toLowerCase() == entityType.toLowerCase(),
        )
        .toList();
  }

  Future<void> toggleSaves({
    required String entityType,
    required int entityId,
  }) async {
    final index = _saves.indexWhere(
      (favorite) =>
          favorite.entityType.toLowerCase() == entityType.toLowerCase() &&
          favorite.entityId == entityId,
    );

    if (index != -1) {
      _saves.removeAt(index);
    } else {
      _saves.add(
        SavedModel(
          id: _nextId++,
          entityType: entityType,
          entityId: entityId,
          savedAt: DateTime.now(),
        ),
      );
    }
  }

  Future<bool> checkSave({
    required String entityType,
    required int entityId,
  }) async {
    return _saves.any(
      (favorite) =>
          favorite.entityType.toLowerCase() == entityType.toLowerCase() &&
          favorite.entityId == entityId,
    );
  }
}
