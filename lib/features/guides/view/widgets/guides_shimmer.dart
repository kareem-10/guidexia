import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GuidesShimmer extends StatelessWidget {
  const GuidesShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListView.separated(
      padding: const EdgeInsets.all(18),
      itemCount: 4,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, _) => Shimmer.fromColors(
        baseColor: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFE7EAEC),
        highlightColor: isDark
            ? const Color(0xFF3A3A3A)
            : const Color(0xFFF7F8F9),
        child: Container(
          height: 132,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
