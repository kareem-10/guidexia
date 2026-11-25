import 'package:flutter/material.dart';
import 'package:tourist_app/features/profile/data/models/profile_model.dart';
import 'package:tourist_app/features/profile/view/widgets/list_sheet.dart';

void showTrips(
  BuildContext context, {
  required List<TripModel> upcomingTrips,
  required List<TripModel> pastTrips,
}) {
  final scheme = Theme.of(context).colorScheme;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: scheme.surface,
    builder: (_) => Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: ListSheet(
        title: 'My Trips',
        emptyText: 'No trips yet. Your future adventures will appear here.',
        isEmpty: upcomingTrips.isEmpty && pastTrips.isEmpty,
        children: [
          if (upcomingTrips.isNotEmpty) ...[
            _buildSectionTitle('Upcoming Trips', scheme),
            ...upcomingTrips.map((trip) => _buildTripTile(trip, scheme)),
          ],

          if (pastTrips.isNotEmpty) ...[
            _buildSectionTitle('Past Trips', scheme),
            ...pastTrips.map((trip) => _buildTripTile(trip, scheme)),
          ],
        ],
      ),
    ),
  );
}

Widget _buildSectionTitle(String title, ColorScheme scheme) {
  return Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 8, left: 16, right: 16),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: scheme.primary,
        ),
      ),
    ),
  );
}

Widget _buildTripTile(TripModel trip, ColorScheme scheme) {
  return ListTile(
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
  );
}
