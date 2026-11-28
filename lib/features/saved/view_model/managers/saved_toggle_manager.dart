import 'package:tourist_app/features/saved/data/models/saved_model.dart';
import 'package:tourist_app/features/saved/data/repos/saved_repo.dart';
import 'package:tourist_app/features/saved/view_model/helpers/saved_helper.dart';

class SavedToggleManager {
  final SavedRepository savedRepository;

  final Set<String> togglingItems = {};

  SavedToggleManager(this.savedRepository);

  Future<void> toggle({
    required String entityType,
    required int entityId,
    required List<SavedModel> Function() getCurrentSaves,
    required void Function(List<SavedModel>) onUpdate,
  }) async {
    final normalizedType = SavedHelper.normalizeType(entityType);
    final key = '${normalizedType.toLowerCase()}_$entityId';

    if (togglingItems.contains(key)) return;

    togglingItems.add(key);

    final originalSaves = List<SavedModel>.from(getCurrentSaves());

    final wasSaved = SavedHelper.isSaved(
      saves: originalSaves,
      entityType: normalizedType,
      entityId: entityId,
    );

    final updatedSaves = List<SavedModel>.from(originalSaves);

    if (wasSaved) {
      updatedSaves.removeWhere(
        (save) =>
            SavedHelper.normalizeType(save.entityType) == normalizedType &&
            save.entityId == entityId,
      );
    } else {
      updatedSaves.add(
        SavedModel(
          id: -DateTime.now().microsecondsSinceEpoch,
          entityType: normalizedType,
          entityId: entityId,
          savedAt: DateTime.now(),
        ),
      );
    }

    onUpdate(updatedSaves);

    try {
      final result = await savedRepository.toggleSaves(
        entityType: normalizedType,
        entityId: entityId,
      );

      result.fold((failure) {
        _rollback(
          entityType: normalizedType,
          entityId: entityId,
          wasSaved: wasSaved,
          originalSaves: originalSaves,
          getCurrentSaves: getCurrentSaves,
          onUpdate: onUpdate,
        );
      }, (data) {});
    } catch (_) {
      _rollback(
        entityType: normalizedType,
        entityId: entityId,
        wasSaved: wasSaved,
        originalSaves: originalSaves,
        getCurrentSaves: getCurrentSaves,
        onUpdate: onUpdate,
      );
    } finally {
      togglingItems.remove(key);
    }
  }

  void _rollback({
    required String entityType,
    required int entityId,
    required bool wasSaved,
    required List<SavedModel> originalSaves,
    required List<SavedModel> Function() getCurrentSaves,
    required void Function(List<SavedModel>) onUpdate,
  }) {
    final rollbackSaves = List<SavedModel>.from(getCurrentSaves());

    rollbackSaves.removeWhere(
      (save) =>
          SavedHelper.normalizeType(save.entityType) == entityType &&
          save.entityId == entityId,
    );

    if (wasSaved) {
      rollbackSaves.addAll(
        originalSaves.where(
          (save) =>
              SavedHelper.normalizeType(save.entityType) == entityType &&
              save.entityId == entityId,
        ),
      );
    }

    onUpdate(rollbackSaves);
  }
}
