import 'package:flutter/material.dart';

class StayImage extends StatelessWidget {
  final String imageUrl;

  const StayImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: double.infinity,
      height: 210,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: 210,
          width: double.infinity,
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          child: Icon(
            Icons.hotel_outlined,
            size: 48,
            color: Colors.grey.shade500,
          ),
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          height: 210,
          width: double.infinity,
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          child: Image(image: const AssetImage('assets/images/loading.gif')),
        );
      },
    );
  }
}
