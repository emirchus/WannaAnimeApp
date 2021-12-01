import 'package:flutter/material.dart';


class ButtonComponent extends StatelessWidget {

  final void Function()? onTap;
  final String text;
  final IconData icon;
  final Color? primary;
  final Color? secondary;

  const ButtonComponent(this.text, this.icon, {Key? key, this.onTap, this.primary, this.secondary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: primary,
        onPrimary: secondary?.withOpacity(.2),
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      onPressed: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: secondary ?? Theme.of(context).textTheme.button!.color),
          const SizedBox(width: 8),
          Text(text, style: Theme.of(context).textTheme.button!.copyWith(
            color: secondary,
            fontWeight: FontWeight.bold
          )),
        ],
      ),
    );
  }
}