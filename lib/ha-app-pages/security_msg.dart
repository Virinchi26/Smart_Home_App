import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';
import 'package:flutter/foundation.dart';

class Message extends StatelessWidget {
  const Message({super.key});

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
            padding:
                EdgeInsets.fromLTRB(18 * fem, 131 * fem, 19 * fem, 143 * fem),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xfffcf2e6),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30 * fem),
                bottomLeft: Radius.circular(30 * fem),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x26000000),
                  offset: Offset(40 * fem, 44 * fem),
                  blurRadius: 32 * fem,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 55 * fem, 42 * fem),
                  constraints: BoxConstraints(
                    maxWidth: 253 * fem,
                  ),
                  child: Text(
                    'Someone is at your door!',
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 35 * ffem,
                      fontWeight: FontWeight.w700,
                      height: 1.1399999346 * ffem / fem,
                      color: const Color(0xff000000),
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 50 * fem),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xffd9d9d9),
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 338 * fem,
                      height: 225 * fem,
                      child: Image.asset(
                        'assets/ha-app-pages/images/default.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 36 * fem),
                  child: Text(
                    'Would you like to let them in?',
                    textAlign: TextAlign.center,
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 21 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.1400000254 * ffem / fem,
                      color: const Color(0xff000000),
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.fromLTRB(50 * fem, 0 * fem, 50 * fem, 0 * fem),
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 98 * fem, 0 * fem),
                        width: 70 * fem,
                        height: 70 * fem,
                        child: InkWell(
                          onTap: () async {
                            if (kDebugMode) {
                              print('User let\'s them in');
                            }
                          },
                          child: ClipOval(
                            child: Image.asset(
                              'assets/ha-app-pages/images/checkmark.png',
                              fit: BoxFit.cover,
                              width: 70 * fem,
                              height: 70 * fem,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 70 * fem,
                        height: 70 * fem,
                        child: InkWell(
                          onTap: () async {
                            if (kDebugMode) {
                              print('User doesn\'t let them in');
                            }
                          },
                          child: ClipOval(
                            child: Image.asset(
                              'assets/ha-app-pages/images/cancel.png',
                              fit: BoxFit.cover,
                              width: 70 * fem,
                              height: 70 * fem,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
