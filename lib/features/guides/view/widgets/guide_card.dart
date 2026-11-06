import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/core/widgets/favorite_icon_button.dart';
import 'package:tourist_app/features/guides/view/screens/guide_details_screen.dart';
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
          MaterialPageRoute(builder: (_) => GuideDetailsScreen(guide: guide)),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            guide.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: scheme.onSurface,
                            ),
                          ),
                        ),
                        if (guide.isVerified)
                          Icon(
                            Icons.verified,
                            color: scheme.primary,
                            size: 17.sp,
                          ),
                      ],
                    ),
                    verticalSpace(4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 15.sp,
                          color: scheme.onSurfaceVariant,
                        ),
                        horizontalSpace(3),
                        Expanded(
                          child: Text(
                            guide.location.isEmpty
                                ? 'Location not provided'
                                : guide.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(6),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: scheme.tertiary,
                          size: 17.sp,
                        ),
                        horizontalSpace(3),
                        Text(
                          guide.averageRating.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: scheme.onSurface,
                          ),
                        ),
                        horizontalSpace(4),
                        Text(
                          '(${guide.reviewCount})',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(7),
                    Text(
                      guide.specialties.isEmpty
                          ? 'Tour guide'
                          : guide.specialties,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: scheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    verticalSpace(8),
                    Row(
                      children: [
                        Text(
                          '${guide.experienceYears} yrs experience',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '\$${guide.pricePerPerson.toStringAsFixed(0)}/person',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w800,
                            color: scheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
