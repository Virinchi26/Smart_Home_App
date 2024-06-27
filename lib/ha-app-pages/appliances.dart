import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/ha-app-pages/alert.dart';
import 'package:myapp/utils.dart';

final _firestore = FirebaseFirestore.instance;

class Appliances extends StatefulWidget {
  const Appliances({super.key});

  @override
  State<Appliances> createState() => _AppliancesState();
}

class _AppliancesState extends State<Appliances> {
  bool _isLight1Pressed = false;
  bool _isFan1Pressed = false;
  bool _isFan2Pressed = false;
  bool _isLight2Pressed = false;
  bool _isButton5pressed = false;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: 794 * fem,
          width: double.infinity,
          child: Container(
            padding: EdgeInsets.fromLTRB(0 * fem, 315 * fem, 0 * fem, 0 * fem),
            width: double.infinity,
            height: 812 * fem,
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30 * fem),
                bottomLeft: Radius.circular(30 * fem),
              ),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/ha-app-pages/images/appliances_bg.jpg',
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
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('devices').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Color(0xffbcf247),
                    ),
                  );
                }
                final switches = snapshot.data!.docs;

                _isFan1Pressed = switches[0].get('1');
                _isFan2Pressed = switches[0].get('2');
                _isLight1Pressed = switches[1].get('1');
                _isLight2Pressed = switches[1].get('2');
                _isButton5pressed = switches[1].get('3');

                return Container(
                  padding:
                      EdgeInsets.fromLTRB(18 * fem, 18 * fem, 0 * fem, 0 * fem),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xbf1e1e1e),
                    borderRadius: BorderRadius.circular(30 * fem),
                  ),
                  child: ClipRect(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // padding: EdgeInsets.fromLTRB(0 * fem, 7 * fem, 0 * fem, 0 * fem),
                          margin: EdgeInsets.fromLTRB(
                              12 * fem, 0 * fem, 0 * fem, 2 * fem),
                          child: Text(
                            'Devices',
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 25 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.14 * ffem / fem,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 7 * fem, 8 * fem),
                          width: double.infinity,
                          height: 166 * fem,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 175 * fem,
                                height: double.infinity,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0 * fem,
                                      top: 12 * fem,
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(15 * fem,
                                            116 * fem, 15 * fem, 15 * fem),
                                        width: 163 * fem,
                                        height: 154 * fem,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff1c242a),
                                          borderRadius:
                                              BorderRadius.circular(30 * fem),
                                        ),
                                        child: Text(
                                          'Light 1',
                                          style: SafeGoogleFont(
                                            'Poppins',
                                            fontSize: 20 * ffem,
                                            fontWeight: FontWeight.w300,
                                            height: 1.1399999619 * ffem / fem,
                                            color: const Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 75 * fem,
                                      top: 0 * fem,
                                      child: Align(
                                        child: Container(
                                          width: 100 * fem,
                                          height: 100 * fem,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              setState(() {
                                                _isLight1Pressed =
                                                    !_isLight1Pressed;
                                                _firestore
                                                    .collection('devices')
                                                    .doc('lights')
                                                    .update({
                                                  '1': _isLight1Pressed
                                                });
                                                if (_isLight1Pressed) {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const AlertPage(
                                                                  applianceNumber:
                                                                      '1',
                                                                  applianceType:
                                                                      'lights')));
                                                }
                                              });
                                            },
                                            child: ClipOval(
                                              child: Image.asset(
                                                _isLight1Pressed
                                                    ? 'assets/ha-app-pages/images/light_on.png'
                                                    : 'assets/ha-app-pages/images/light_off.png',
                                                fit: BoxFit.cover,
                                                width: 100 * fem,
                                                height: 100 * fem,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 175 * fem,
                                height: double.infinity,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0 * fem,
                                      top: 12 * fem,
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(15 * fem,
                                            116 * fem, 15 * fem, 15 * fem),
                                        width: 163 * fem,
                                        height: 154 * fem,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff1c242a),
                                          borderRadius:
                                              BorderRadius.circular(30 * fem),
                                        ),
                                        child: Text(
                                          'Fan 1',
                                          style: SafeGoogleFont(
                                            'Poppins',
                                            fontSize: 20 * ffem,
                                            fontWeight: FontWeight.w300,
                                            height: 1.1399999619 * ffem / fem,
                                            color: const Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 75 * fem,
                                      top: 0 * fem,
                                      child: Align(
                                        child: Container(
                                          width: 100 * fem,
                                          height: 100 * fem,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              setState(() {
                                                _isFan1Pressed =
                                                    !_isFan1Pressed;
                                                _firestore
                                                    .collection('devices')
                                                    .doc('fans')
                                                    .update(
                                                        {'1': _isFan1Pressed});
                                                if (_isFan1Pressed) {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const AlertPage(
                                                                  applianceNumber:
                                                                      '1',
                                                                  applianceType:
                                                                      'fans')));
                                                }
                                              });
                                            },
                                            child: ClipOval(
                                              child: Image.asset(
                                                _isFan1Pressed
                                                    ? 'assets/ha-app-pages/images/fan_on.png'
                                                    : 'assets/ha-app-pages/images/fan_off.png',
                                                fit: BoxFit.cover,
                                                width: 100 * fem,
                                                height: 100 * fem,
                                              ),
                                            ),
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
                        SizedBox(
                          width: double.infinity,
                          height: 257 * fem,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 175 * fem,
                                height: 166 * fem,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0 * fem,
                                      top: 12 * fem,
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(15 * fem,
                                            116 * fem, 15 * fem, 15 * fem),
                                        width: 163 * fem,
                                        height: 154 * fem,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff1c242a),
                                          borderRadius:
                                              BorderRadius.circular(30 * fem),
                                        ),
                                        child: Text(
                                          'Fan 2',
                                          style: SafeGoogleFont(
                                            'Poppins',
                                            fontSize: 20 * ffem,
                                            fontWeight: FontWeight.w300,
                                            height: 1.1399999619 * ffem / fem,
                                            color: const Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 75 * fem,
                                      top: 0 * fem,
                                      child: Align(
                                        child: Container(
                                          width: 100 * fem,
                                          height: 100 * fem,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              setState(() {
                                                _isFan2Pressed =
                                                    !_isFan2Pressed;
                                                _firestore
                                                    .collection('devices')
                                                    .doc('fans')
                                                    .update(
                                                        {'2': _isFan2Pressed});
                                                if (_isFan2Pressed) {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const AlertPage(
                                                                  applianceNumber:
                                                                      '2',
                                                                  applianceType:
                                                                      'fans')));
                                                }
                                              });
                                            },
                                            child: ClipOval(
                                              child: Image.asset(
                                                _isFan2Pressed
                                                    ? 'assets/ha-app-pages/images/fan_on.png'
                                                    : 'assets/ha-app-pages/images/fan_off.png',
                                                fit: BoxFit.cover,
                                                width: 100 * fem,
                                                height: 100 * fem,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 182 * fem,
                                height: double.infinity,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0 * fem,
                                      top: 12 * fem,
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(15 * fem,
                                            116 * fem, 15 * fem, 15 * fem),
                                        width: 163 * fem,
                                        height: 154 * fem,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff1c242a),
                                          borderRadius:
                                              BorderRadius.circular(30 * fem),
                                        ),
                                        child: Text(
                                          'Light 2',
                                          style: SafeGoogleFont(
                                            'Poppins',
                                            fontSize: 20 * ffem,
                                            fontWeight: FontWeight.w300,
                                            height: 1.1399999619 * ffem / fem,
                                            color: const Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 75 * fem,
                                      top: 0 * fem,
                                      child: Align(
                                        child: Container(
                                          width: 100 * fem,
                                          height: 100 * fem,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              setState(() {
                                                _isLight2Pressed =
                                                    !_isLight2Pressed;
                                                _firestore
                                                    .collection('devices')
                                                    .doc('lights')
                                                    .update({
                                                  '2': _isLight2Pressed
                                                });
                                                if (_isLight2Pressed) {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const AlertPage(
                                                                  applianceNumber:
                                                                      '2',
                                                                  applianceType:
                                                                      'lights')));
                                                }
                                              });
                                            },
                                            child: ClipOval(
                                              child: Image.asset(
                                                _isLight2Pressed
                                                    ? 'assets/ha-app-pages/images/light_on.png'
                                                    : 'assets/ha-app-pages/images/light_off.png',
                                                fit: BoxFit.cover,
                                                width: 100 * fem,
                                                height: 100 * fem,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 89 * fem,
                                      top: 164 * fem,
                                      child: Align(
                                        child: Container(
                                          width: 93 * fem,
                                          height: 93 * fem,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              setState(() {
                                                _isButton5pressed =
                                                    !_isButton5pressed;
                                                _firestore
                                                    .collection('devices')
                                                    .doc('lights')
                                                    .update({
                                                  '3': _isButton5pressed
                                                });
                                              });
                                            },
                                            child: ClipOval(
                                              child: Image.asset(
                                                _isButton5pressed
                                                    ? 'assets/ha-app-pages/images/child_mode_on.png'
                                                    : 'assets/ha-app-pages/images/child_mode_off.png',
                                                fit: BoxFit.cover,
                                                width: 93 * fem,
                                                height: 93 * fem,
                                              ),
                                            ),
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
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
