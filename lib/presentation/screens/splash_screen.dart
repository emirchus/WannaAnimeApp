import 'package:flutter/material.dart';
import 'package:wannaanime/presentation/providers/global_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  late GlobalProvider globalProvider;

  @override
  void initState() {
    super.initState();
    globalProvider = GlobalProvider.of(context, listen: false);

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      _controller.forward();
      await globalProvider.fetchAnimeList();
      await _controller.reverse();
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
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
