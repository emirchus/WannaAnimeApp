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
   return AnimatedBuilder(
     animation: shimmerController,
     builder: (context, child) {
       final skeletonGradient = LinearGradient(
        colors: const [
          Color(0xFFEBEBF4),
          Color(0xFFF4F4F4),
          Color(0xFFEBEBF4),
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
       width: double.infinity,
       decoration: BoxDecoration(
         color: Colors.black,
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