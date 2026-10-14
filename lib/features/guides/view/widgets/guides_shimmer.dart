import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GuidesShimmer extends StatelessWidget {
  const GuidesShimmer({super.key});
  @override
  Widget build(BuildContext context) => ListView.separated(
    padding: const EdgeInsets.all(18),
    itemCount: 4,
    separatorBuilder: (_, __) => const SizedBox(height: 12),
    itemBuilder: (_, __) => Shimmer.fromColors(
      baseColor: const Color(0xFFE7EAEC), highlightColor: const Color(0xFFF7F8F9),
      child: Container(height: 132, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18))),
    ),
  );
}
