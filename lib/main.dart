import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/primary_color.dart';
import 'package:myapp/ha-app-pages/splash.dart';
// import 'package:myapp/ha-app-pages/alert.dart';
// import 'package:myapp/ha-app-pages/security_msg.dart';
// import 'package:myapp/ha-app-pages/appliances.dart';
// import 'package:myapp/ha-app-pages/alert.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        primarySwatch: primary,
      ),
      home: const Splash(),
    );
  }
}
