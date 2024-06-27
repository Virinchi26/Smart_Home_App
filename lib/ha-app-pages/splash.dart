import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/ha-app-pages/homepage.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 5450), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBBF247),
      body: SafeArea(
        child: Center(
          child: Container(
            child: Lottie.asset(
              'assets/ha-app-pages/animations/splash.json',
              width: 150,
              controller: _controller,
              onLoaded: (comp) {
                _controller.duration = comp.duration;
                _controller.forward();
              },
            ),
          ),
        ),
      ),
    );
  }
}
