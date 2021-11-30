import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wannaanime/presentation/widgets/cached_network_image.dart';


class AnimeBanner extends StatefulWidget {

  final String animeId;
  final String imageUrl;
  final ScrollController controller;

  const AnimeBanner({Key? key, required this.animeId, required this.imageUrl, required this.controller}) : super(key: key);
  @override
  State<AnimeBanner> createState() => _AnimeBannerState();
}

class _AnimeBannerState extends State<AnimeBanner> {

  late ScrollController scrollController;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    scrollController = widget.controller;
    scrollController.addListener(onScroll);
  }

  void onScroll() {
    setState(() {
      progress = (scrollController.offset / scrollController.position.maxScrollExtent) * (scrollController.position.maxScrollExtent / scrollController.position.viewportDimension);
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(onScroll);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    var sigma = (10 * (progress / 2) ).clamp(0.0, 10.0);

    return ClipRRect(
      child: Hero(
        tag: widget.animeId,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 10),
          curve: Curves.ease,
          scale: (8 * progress).clamp(1, 2),
          child: AspectRatio(
            aspectRatio: 16/16,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
              child: CachedImage(
                widget.imageUrl,
                fit: BoxFit.cover,
                width: size.width,
                height: size.width * 16 / 16,
              ),
            ),
          ),
        ),
      ),
    );
  }}