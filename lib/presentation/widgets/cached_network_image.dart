import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {

  final double? width, height;
  final BoxFit? fit;
  final double? radius;
  final String url;

  const CachedImage(this.url, {Key? key, this.width, this.height, this.fit, this.radius}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit,
        cacheKey: url,
        alignment: Alignment.center,

        placeholder: (context, url) => SizedBox(
          width: width ?? MediaQuery.of(context).size.width * 0.8,
          height: height ?? MediaQuery.of(context).size.width * 0.8,
          child: const Center(
            child: CircularProgressIndicator(),
          )
        ),
        errorWidget: (context, url, error) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20  ),
            color: Colors.white,
          ),
          child: Center(
            child: Text('Hubo un error al cargar la imagen!', style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontWeight: FontWeight.bold
            )),
          )
        ),
      ),
    );
  }
}