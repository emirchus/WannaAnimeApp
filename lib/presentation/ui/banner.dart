
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class Banners extends StatefulWidget {

  final String animeId;
  final String imageUrl;
  final ScrollController controller;
  final Color background;

  const Banners({Key? key, required this.animeId, required this.background, required this.imageUrl, required this.controller}) : super(key: key);
  @override
  State<Banners> createState() => _BannersState();
}

class _BannersState extends State<Banners> {

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

    return ClipRRect(
      child: Hero(
        tag: widget.animeId,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 10),
          curve: Curves.ease,
          scale: (8 * progress).clamp(1, 2),
          child: Container(
            width: size.width,
            height: size.width * 16 / 16,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(widget.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: widget.background.withOpacity((progress * 5.0).clamp(0.0, 1.0)),
            ),
          )
        ),
      ),
    );
  }}