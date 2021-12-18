import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wannaanime/presentation/widgets/lookea_icons.dart';


class Navbar extends StatelessWidget {

  final int currentIndex;
  final Function(int)? onChange;

  const Navbar({Key? key, required this.currentIndex, required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            color: Colors.black12,
            notchMargin: 8,
            elevation: 0,
            child: Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                NavButton(
                  icon: LookeaIcons.clapper_board,
                  text: 'Anime',
                  isActive: currentIndex == 0,
                  onTap: () => onChange?.call(0),
                ),
                NavButton(
                  icon: LookeaIcons.book,
                  text: 'Manga',
                  isActive: currentIndex == 1,
                  onTap: () => onChange?.call(1),
                ),
                NavButton(
                  icon: LookeaIcons.dice_two,
                  text: 'Random',
                  isActive: currentIndex == 2,
                  onTap: () => onChange?.call(2),
                ),
                NavButton(
                  icon: LookeaIcons.feedback,
                  isActive: currentIndex == 4,
                  onTap: () => onChange?.call(4),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }

}

class NavButton extends StatelessWidget {

  final IconData icon;
  final Function() onTap;
  final bool isActive;
  final String? text;

  const NavButton({ Key? key, required this.icon, required this.onTap, required this.isActive, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: isActive ? 2 : 1,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onPrimary: Colors.black,
          shadowColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : Theme.of(context).primaryColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(icon, color: isActive ? Colors.white : Colors.black38,),
            if(isActive && text != null)
              Text(text!, style: const TextStyle(color: Colors.white, fontSize: 14),),
          ],
        ),
      ),
    );
  }
}
