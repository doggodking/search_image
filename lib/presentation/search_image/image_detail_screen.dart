import 'package:flutter/material.dart';
import 'package:image_search_app/presentation/component/app_image.dart';
import 'package:image_search_app/presentation/component/skelton_animtion_widget.dart';

class ImageDetailScreen extends StatelessWidget {
  final String imageUrl;

  const ImageDetailScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('이미지 보기')),
      body: InteractiveViewer(
        panEnabled: true,
        scaleEnabled: true,
        minScale: 1.0,
        maxScale: 4.0,
        child: Center(
          child: SizedBox(
            width: screenSize.width,
            height: screenSize.height,
            child: AppImage(
              path: imageUrl,
              fit: BoxFit.contain,
              skeletonBuilder:
                  (context, size) => SkeletonAnimationWidget(size: size),
            ),
          ),
        ),
      ),
    );
  }
}
