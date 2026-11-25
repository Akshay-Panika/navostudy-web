// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'features/auth/screen/splash_screen.dart';
import 'features/dashboard/screen/dashboard_screen.dart';
import 'firebase_options.dart';

void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  VisibilityDetectorController.instance.updateInterval = Duration(seconds: 2);
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
    return MaterialApp(
      title: "Navo Study",
      debugShowCheckedModeBanner: false,
      home: Stack(
        fit: StackFit.expand,
        children: [
          // 🟢 Dashboard builds IMMEDIATELY — behind splash
          // LandingScreen animations run while splash is on top
          const DashboardScreen(),

          // 🔵 Splash overlays on top → fades out when everything is ready
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
