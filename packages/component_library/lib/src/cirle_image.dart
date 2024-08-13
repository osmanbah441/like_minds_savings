import 'package:flutter/material.dart';

class CirleImage extends StatelessWidget {
  const CirleImage({
    super.key,
    required this.photoURL,
    this.radius = 32,
  });

  final String? photoURL;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: photoURL != null
          ? NetworkImage(photoURL!)
          : const AssetImage(
              'assets/images/osman-bah.jpeg',
              package: 'component_library',
            ),
    );
  }
}
