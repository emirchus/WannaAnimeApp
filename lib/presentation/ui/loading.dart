import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  final Future<void> Function() future;
  const Loading({Key? key, required this.future}) : super(key: key);

  static Future<void> show(BuildContext context, future) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Loading(future: future,);
      },
    );
  }

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      _controller.forward();
      await widget.future();
      await _controller.reverse();
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox.fromSize(
      size: size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child){
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
            opacity: _controller.value.clamp(0.0, 1.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutExpo,
                  top: (size.height / 3) * (_controller.value),
                  child: const Center(
                    child: Image(
                      image: AssetImage('assets/images/logo-s-1000.png'),
                      height: 200,
                    ),
                  )
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutExpo,
                  bottom: (size.height / 3) * (_controller.value),
                  child: const Center(
                    child: CircularProgressIndicator()
                  )
                ),
              ],
            )
          );
        },
      ),
    );
  }
}
