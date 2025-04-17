import 'package:flutter/material.dart';

class SkeletonAnimationWidget extends StatefulWidget {
  final Size size;

  const SkeletonAnimationWidget({super.key, required this.size});

  @override
  State<SkeletonAnimationWidget> createState() =>
      _SkeletonAnimationWidgetState();
}

class _SkeletonAnimationWidgetState extends State<SkeletonAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (_, __) {
            return ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: const [
                    Color(0xFFE0F7FA),
                    Color(0xFF4FB6B2),
                    Color(0xFF81D4FA),
                  ],
                  stops: [0.0, (_animation.value + 2) / 4, 1.0],
                ).createShader(bounds);
              },
              child: Container(
                width: size.width,
                height: size.height,
                color: const Color(0xFF4FB6B2),
              ),
            );
          },
        ),

        RotationTransition(
          turns: _controller,
          child: Icon(
            Icons.sync, // 추천 아이콘: downloading, sync, refresh 등
            size: size.shortestSide * 0.15,
            color: Colors.teal.shade300,
          ),
        ),
      ],
    );
  }
}
