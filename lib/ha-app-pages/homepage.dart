import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/ha-app-pages/appliances.dart';
import 'package:myapp/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 0.93).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: 813,
          width: double.infinity,
          child: Container(
            padding: EdgeInsets.fromLTRB(0 * fem, 500 * fem, 0 * fem, 0 * fem),
            width: double.infinity,
            height: 812 * fem,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30 * fem),
                bottomLeft: Radius.circular(30 * fem),
              ),
              color: const Color(0xff000000),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/ha-app-pages/images/homepage_bg.png',
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x26000000),
                  offset: Offset(40 * fem, 44 * fem),
                  blurRadius: 42 * fem,
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  15.5 * fem, 33.5 * fem, 15.5 * fem, 36 * fem),
              width: double.infinity,
              height: 750,
              decoration: BoxDecoration(
                color: const Color(0xbf1e1e1e),
                borderRadius: BorderRadius.all(Radius.circular(30 * fem)),
              ),
              child: ClipRect(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 1 * fem, 29.5 * fem),
                        constraints: BoxConstraints(
                          maxWidth: 263 * fem,
                        ),
                        child: Text(
                          'Welcome to the Smart Home App!',
                          textAlign: TextAlign.center,
                          style: SafeGoogleFont(
                            'Poppins',
                            fontSize: 29 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.5 * ffem / fem,
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 36 * fem),
                        child: Text(
                          'Control your smart home at your fingertips!',
                          textAlign: TextAlign.center,
                          style: SafeGoogleFont(
                            'Poppins',
                            fontSize: 15 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * ffem / fem,
                            letterSpacing: 0.45 * fem,
                            color: const Color(0xff9e9e9e),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          84.5 * fem, 0 * fem, 84.5 * fem, 0 * fem),
                      width: double.infinity,
                      height: 55 * fem,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffbcf247),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50 * fem),
                          ),
                          elevation: 5,
                        ),
                        onPressed: () {
                          _controller.forward();
                          Timer(const Duration(milliseconds: 400), () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 550),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const Appliances(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  var begin = const Offset(0.0, 1.0);
                                  var end = Offset.zero;
                                  var curve = Curves.ease;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          });
                        },
                        child: AnimatedBuilder(
                          animation: _scaleAnimation,
                          builder: (context, child) => Transform.scale(
                            scale: _scaleAnimation.value,
                            child: child,
                          ),
                          child: Text(
                            'Get Started',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 19 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * ffem / fem,
                              letterSpacing: 0.57 * fem,
                              color: const Color(0xff000000),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
