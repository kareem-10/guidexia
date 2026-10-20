import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/utils/app_colors.dart';
import 'package:tourist_app/core/widgets/favorite_icon_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/stay_model.dart';
import 'stay_details.dart';
import 'stay_image.dart';

class StayCard extends StatelessWidget {
  final StayModel stay;

  const StayCard({super.key, required this.stay});

  Future<void> _openWebsite(BuildContext context) async {
    final uri = Uri.tryParse(stay.websiteUrl);

    if (uri == null ||
        !uri.hasScheme ||
        (uri.scheme != 'https' && uri.scheme != 'http') ||
        uri.host.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking website is not available.')),
      );
      return;
    }

    try {
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);

      if (!opened && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the booking website.')),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the booking website.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              StayImage(
                imageUrl: stay.thumbnailUrl.isNotEmpty
                    ? stay.thumbnailUrl
                    : stay.imageUrl,
              ),
              //margin
              Padding(
                padding: EdgeInsets.all(10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 7.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        stay.type,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    FavoriteIconButton(entityId: stay.id, entityType: 'Stay'),
                  ],
                ),
              ),
            ],
          ),
          StayDetails(stay: stay),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: () => _openWebsite(context),
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  backgroundColor: AppColors.primaryColor,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        'Visit Website / Book Now',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.open_in_new, size: 18),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
