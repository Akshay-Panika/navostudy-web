import 'package:flutter/material.dart';
import 'package:navostudy/features/testimonials/screen/testimonials_screen.dart';

import '../../footer/screen/footer_screen.dart';
import '../../landing/screen/landing_screen.dart';
import '../../management/screen/management_page.dart';
import '../../package/screen/package_screen.dart';
import '../../response/screen/responce_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LandingScreen(),
        ResponseScreen(),
        TestimonialsScreen(),
        ManagementPage(),
        PackageScreen(),
      ],
    );
  }
}
