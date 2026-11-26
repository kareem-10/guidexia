import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/core/widgets/favorite_icon_button.dart';
import 'package:tourist_app/features/guides/view/screens/guide_details_screen.dart';
import 'package:tourist_app/features/guides/view/widgets/guide_card_info.dart';
import '../../data/models/guide_model.dart';

class GuideCard extends StatelessWidget {
  final GuideModel guide;
  const GuideCard({super.key, required this.guide});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => GuideDetailsScreen(guideId: guide.id),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: guide.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: CachedNetworkImage(
                    imageUrl: guide.profileImageUrl ?? '',
                    width: 76.w,
                    height: 88.h,
                    fit: BoxFit.cover,
                    placeholder: (_, _) => Container(
                      width: 76.w,
                      height: 88.h,
                      color: scheme.surfaceContainerHighest,
                      child: Icon(Icons.person, color: scheme.onSurfaceVariant),
                    ),
                    errorWidget: (_, _, _) => Container(
                      width: 76.w,
                      height: 88.h,
                      color: scheme.surfaceContainerHighest,
                      child: Icon(Icons.person, color: scheme.onSurfaceVariant),
                    ),
                  ),
                ),
              ),
              horizontalSpace(12),
              Expanded(child: GuideCardInfo(guide: guide)),
              FavoriteIconButton(
                entityId: guide.id,
                entityType: 'Guide',
                overlay: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
