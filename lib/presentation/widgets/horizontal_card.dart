import 'package:flutter/material.dart';
import 'package:wannaanime/presentation/widgets/cached_network_image.dart';


class HorizontalCard extends StatelessWidget {

  final String imageUrl;
  final String title;
  final String description;
  final Function() onTap;

  const HorizontalCard({Key? key,required this.imageUrl, required this.title, required this.description, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: size.width,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(
            color: Colors.black12,
            width: 1.5,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset.zero,
            ),
          ]
        ),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 2,
              child: Flex(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(title, textAlign: TextAlign.start, maxLines: 2, overflow: TextOverflow.fade, softWrap: true, style: theme.textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
                  const SizedBox(height: 5),
                  Text(description, textAlign: TextAlign.start, maxLines: 4, overflow: TextOverflow.ellipsis, softWrap: true, style: theme.textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.w500,
                  )),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: CachedImage(imageUrl, fit: BoxFit.cover, height: 140, width: 140, radius: 20,),
            )
          ]
        ),
      ),
    );
  }
}