import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/core/utils/app_colors.dart';
import '../../data/models/guide_model.dart';
import '../../view_model/cubit/guides_cubit.dart';

class GuideCard extends StatelessWidget {
  final GuideModel guide;
  final VoidCallback onTap;
  const GuideCard({super.key, required this.guide, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GuidesCubit>();
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE6E9EC)),
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
                      color: const Color(0xFFE9EFF0),
                      child: const Icon(Icons.person, color: Colors.grey),
                    ),
                    errorWidget: (_, _, _) => Container(
                      width: 76.w,
                      height: 88.h,
                      color: const Color(0xFFE9EFF0),
                      child: const Icon(Icons.person, color: Colors.grey),
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
                              color: Color(0xFF242B31),
                            ),
                          ),
                        ),
                        if (guide.isVerified)
                          Icon(
                            Icons.verified,
                            color: AppColors.primaryColor,
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
                          color: Colors.blueGrey,
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
                              color: Colors.blueGrey,
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
                          color: Color(0xFFFFB547),
                          size: 17.sp,
                        ),
                        horizontalSpace(3),
                        Text(
                          guide.averageRating.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        horizontalSpace(4),
                        Text(
                          '(${guide.reviewCount})',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.blueGrey,
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
                        color: AppColors.primaryColor,
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
                            color: Colors.blueGrey,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '\$${guide.pricePerPerson.toStringAsFixed(0)}/person',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                tooltip: cubit.isFavorite(guide.id)
                    ? 'Remove from favorites'
                    : 'Add to favorites',
                onPressed: () => cubit.toggleFavorite(guide.id),
                icon: Icon(
                  cubit.isFavorite(guide.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: cubit.isFavorite(guide.id)
                      ? Colors.redAccent
                      : Colors.blueGrey,
                  size: 21.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
