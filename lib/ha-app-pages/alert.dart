import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/ha-app-pages/appliances.dart';
import 'package:myapp/utils.dart';

class AlertPage extends StatefulWidget {
  final String applianceNumber;
  final String applianceType; // "lights" or "fans"

  const AlertPage({
    Key? key,
    required this.applianceNumber,
    required this.applianceType,
  }) : super(key: key);

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  late Timer timer;
  bool onUserResponse = false;
  bool alertDialogShown = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer(const Duration(seconds: 10), () async {
      var docSnapshot = await FirebaseFirestore.instance
          .collection('devices')
          .doc(widget.applianceType)
          .get();

      bool applianceOn = docSnapshot[widget.applianceNumber];
      if (applianceOn) {
        timer.cancel();
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            alertDialogShown = true;
            return AlertDialog(
              title: Text(
                'Alert',
                style: SafeGoogleFont(
                  'Poppins',
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  color: Colors.black,
                ),
              ),
              content: Text(
                'A ${widget.applianceType.replaceAll('s', '')} is still on, are you still in the room?\n\nPlease respond within 5 seconds else the appliance will be switched off.',
                style: SafeGoogleFont(
                  'Poppins',
                  fontSize: 19,
                  fontWeight: FontWeight.w300,
                  height: 1,
                  color: Colors.black,
                ),
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffbcf247),
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    handleUserResponse(true);
                  },
                  child: Text(
                    'Yes',
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      height: 1,
                      color: Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffbcf247),
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    handleUserResponse(false);
                  },
                  child: Text(
                    'No',
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      height: 1,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            );
          },
        ).then((_) {
          alertDialogShown = false;
        });
        Timer(const Duration(seconds: 5), () {
          if (!onUserResponse && alertDialogShown) {
            handleUserResponse(false);
          }
        });
      } else {
        startTimer();
      }
    });
  }

  void resetTimer() {
    timer.cancel();
    onUserResponse = false;
    alertDialogShown = false;
    startTimer();
  }

  Future<void> handleUserResponse(bool response) async {
    if (response) {
      setState(() {
        onUserResponse = true;
      });
      resetTimer();
    } else {
      setState(() {
        onUserResponse = false;
      });
      await FirebaseFirestore.instance
          .collection('devices')
          .doc(widget.applianceType)
          .update({widget.applianceNumber: false});
    }
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return const Appliances();
  }
}
