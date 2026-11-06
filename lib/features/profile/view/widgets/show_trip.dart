import 'package:flutter/material.dart';
import 'package:tourist_app/features/profile/data/models/profile_model.dart';
import 'package:tourist_app/features/profile/view/widgets/list_sheet.dart';

void showTrips(BuildContext context, List<TripModel> trips) {
  final scheme = Theme.of(context).colorScheme;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: scheme.surface,
    builder: (_) => ListSheet(
      title: 'My Trips',
      emptyText: 'No trips yet. Your future adventures will appear here.',
      isEmpty: trips.isEmpty,
      children: trips
          .map(
            (trip) => ListTile(
              leading: CircleAvatar(
                backgroundColor: scheme.surfaceContainerHighest,
                child: Icon(Icons.map_outlined, color: scheme.primary),
              ),
              title: Text(trip.title),
              subtitle: Text('${trip.location} · ${trip.date}'),
              trailing: Text(
                trip.status,
                style: TextStyle(color: scheme.primary, fontSize: 11),
              ),
            ),
          )
          .toList(),
    ),
  );
}

