import 'package:flutter/material.dart';

class Skeleton extends StatefulWidget{
  const Skeleton({Key? key}) : super(key: key);

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> with SingleTickerProviderStateMixin {
  late AnimationController shimmerController = AnimationController.unbounded(vsync: this);

  @override
  void initState() {
    super.initState();
    shimmerController.repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    shimmerController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: shimmerController,
      builder: (context, child) {
        final skeletonGradient = LinearGradient(
          colors: const [
            Colors.white54,
            Colors.white,
            Colors.white54,

          ],
          stops: const [
            0.1,
            0.3,
            0.4,
          ],
          begin: const Alignment(-1.0, -0.3),
          end: const Alignment(1.0, 0.3),
          tileMode: TileMode.clamp,
          transform:_SlidingGradientTransform(slidePercent: shimmerController.value )
        );
        return ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (bounds) {
              return skeletonGradient.createShader(bounds);
            },
            child: child
          ),
        );
      },
      child: Container(
        width: size.width,
        height: 140,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}