import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/utils/app_colors.dart';
import '../../data/models/stay_model.dart';

class StayDetails extends StatelessWidget {
  final StayModel stay;

  const StayDetails({super.key, required this.stay});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  stay.name,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${stay.currency} ${stay.pricePerNight.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Text(
                    'per night',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 18, color: Colors.grey),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  '${stay.city}, ${stay.country}',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 5,
            runSpacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Icon(Icons.star, size: 18, color: Colors.amber),
              Text(
                stay.averageRating.toStringAsFixed(1),
                style: TextStyle(fontSize: 14.sp, color: Colors.amber),
              ),
              Text(
                '(${stay.reviewCount} reviews)',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
              Text(
                ' · ${'★' * stay.starRating}',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            ],
          ),
          if (stay.amenities.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: stay.amenities.map((amenity) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    amenity,
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
