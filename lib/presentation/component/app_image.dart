import 'package:flutter/material.dart';

class AppImage extends StatefulWidget {
  final String path;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final VoidCallback? onImageLoaded;
  final Widget Function(BuildContext context)? overlayBuilder;
  final Widget Function(BuildContext context, Size size)? skeletonBuilder;

  const AppImage({
    super.key,
    required this.path,
    this.fit,
    this.borderRadius,
    this.onImageLoaded,
    this.overlayBuilder,
    this.skeletonBuilder,
  });

  @override
  State<AppImage> createState() => _AppImageState();
}

class _AppImageState extends State<AppImage> {
  bool _loaded = false;

  @override
  Widget build(BuildContext context) {
    final isNetwork = widget.path.toLowerCase().startsWith('http');
    final image = isNetwork ? _buildNetworkImage() : _buildAssetImage();

    return widget.borderRadius != null
        ? ClipRRect(borderRadius: widget.borderRadius!, child: image)
        : image;
  }

  Widget _buildNetworkImage() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);

        return Stack(
          children: [
            Image.network(
              widget.path,
              fit: widget.fit ?? BoxFit.cover,
              width: size.width,
              height: size.height,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                final loaded = wasSynchronouslyLoaded || frame != null;

                if (!_loaded && loaded) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      setState(() => _loaded = true);
                      widget.onImageLoaded?.call();
                    }
                  });
                }
                return child;
              },
              errorBuilder: (_, __, ___) => _errorPlaceholder(size),
            ),
            if (!_loaded && widget.skeletonBuilder != null)
              widget.skeletonBuilder!(context, size),
            if (_loaded && widget.overlayBuilder != null)
              widget.overlayBuilder!(context),
          ],
        );
      },
    );
  }

  Widget _buildAssetImage() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);

        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                widget.path,
                fit: widget.fit ?? BoxFit.cover,
                width: size.width,
                height: size.height,
                errorBuilder: (_, __, ___) => _errorPlaceholder(size),
              ),
            ),
            if (widget.overlayBuilder != null) widget.overlayBuilder!(context),
          ],
        );
      },
    );
  }

  Widget _errorPlaceholder(Size size) => Container(
    width: size.width,
    height: size.height,
    color: Colors.black,
    child: const Icon(Icons.photo, color: Colors.redAccent),
  );
}
