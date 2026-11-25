import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'core/utils/app_binding.dart';
import 'features/auth/screen/splash_screen.dart';
import 'features/dashboard/screen/dashboard_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  VisibilityDetectorController.instance.updateInterval =
  const Duration(seconds: 2);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _splashDone = false;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Navo Study",
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      enableLog: true,
      defaultTransition: Transition.cupertino,
      home: Stack(
        fit: StackFit.expand,
        children: [
          const DashboardScreen(),
          if (!_splashDone)
            SplashScreen(
              onFinished: () {
                if (mounted) setState(() => _splashDone = true);
              },
            ),
        ],
      ),
    );
  }
}