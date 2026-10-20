import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/utils/app_colors.dart';
import 'package:tourist_app/features/saved/view_model/cubit/saved_cubit.dart';
import 'package:tourist_app/features/saved/view_model/cubit/saved_state.dart';

class FavoriteIconButton extends StatelessWidget {
  final int entityId;
  final String entityType;
  final bool overlay;
  final double? iconSize;

  const FavoriteIconButton({
    super.key,
    required this.entityId,
    required this.entityType,
    this.overlay = true,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedCubit, SavedState>(
      builder: (context, state) {
        final cubit = context.read<SavedCubit>();

        final isSaved =
            state is SavedSuccess &&
            state.saves.any(
              (save) =>
                  save.entityType.toLowerCase() == entityType.toLowerCase() &&
                  save.entityId == entityId,
            );

        final toggleKey = '${entityType.toLowerCase()}_$entityId';
        final isToggling = cubit.togglingItems.contains(toggleKey);

        return Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: overlay
                ? AppColors.primaryColor.withValues(alpha: 0.2)
                : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            tooltip: isSaved ? 'Remove from saved' : 'Save',
            onPressed: isToggling || state is! SavedSuccess
                ? null
                : () => cubit.toggleSave(
                    entityType: entityType,
                    entityId: entityId,
                  ),
            icon: Icon(
              isSaved ? Icons.favorite : Icons.favorite_border,
              color: isSaved
                  ? AppColors.primaryColor
                  : overlay
                  ? Colors.white
                  : AppColors.primaryColor.withValues(alpha: 0.4),
              size: (iconSize ?? 19).sp,
            ),
          ),
        );
      },
    );
  }
}
