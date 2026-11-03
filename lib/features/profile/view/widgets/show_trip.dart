import 'package:flutter/material.dart';
import 'package:tourist_app/core/utils/app_colors.dart';
import 'package:tourist_app/features/profile/data/models/profile_model.dart';
import 'package:tourist_app/features/profile/view/widgets/list_sheet.dart';

void showTrips(BuildContext context, List<TripModel> trips) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => ListSheet(
      title: 'My Trips',
      emptyText: 'No trips yet. Your future adventures will appear here.',
      isEmpty: trips.isEmpty,
      children: trips
          .map(
            (trip) => ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(0xFFE7EDE4),
                child: Icon(Icons.map_outlined, color: AppColors.primaryColor),
              ),
              title: Text(trip.title),
              subtitle: Text('${trip.location} · ${trip.date}'),
              trailing: Text(
                trip.status,
                style: TextStyle(color: AppColors.primaryColor, fontSize: 11),
              ),
            ),
          )
          .toList(),
    ),
  );
}
