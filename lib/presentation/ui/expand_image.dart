import 'package:flutter/material.dart';
import 'package:wannaanime/presentation/widgets/cached_network_image.dart';
import 'package:wannaanime/presentation/widgets/zoomeable.dart';


class ExpandImage extends StatelessWidget {

  final String image;

  const ExpandImage({Key? key, required this.image}) : super(key: key);

  static Future show(BuildContext context, String image) async {
    await showDialog<void>(
      context: context,
      barrierColor: Colors.black87,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          child: ExpandImage(image: image),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Zoomable(
      child: CachedImage(
        image,
        width: size.width,
        height: size.height,
      ),
    );
  }
}