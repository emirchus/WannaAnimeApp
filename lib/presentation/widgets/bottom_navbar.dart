import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wannaanime/presentation/theme.dart';
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NavButton(
                  icon: LookeaIcons.home_alt,
                  isActive: currentIndex == 0,
                  onTap: () => onChange?.call(0),
                ),
                NavButton(
                  icon: LookeaIcons.search,
                  isActive: currentIndex == 1,
                  onTap: () => onChange?.call(1),
                ),
                NavButton(
                  icon: LookeaIcons.book,
                  isActive: currentIndex == 2,
                  onTap: () => onChange?.call(2),
                ),
                NavButton(
                  icon: LookeaIcons.dice_two,
                  isActive: currentIndex == 3,
                  onTap: () => onChange?.call(3),
                ),
                NavButton(
                  icon: LookeaIcons.feedback,
                  isActive: currentIndex == 3,
                  onTap: () => onChange?.call(3),
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

  const NavButton({ Key? key, required this.icon, required this.onTap, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      splashRadius: 25,
      iconSize: 30,
      icon: Icon(icon, color: isActive ? AppTheme.primaryColor : Colors.black54, )
    );
  }
}
