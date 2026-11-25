import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart'; // 👈 for SchedulerBinding
import 'package:google_fonts/google_fonts.dart';

import '../../../firebase_options.dart';

class SplashScreen extends StatefulWidget {
  /// Callback jab splash fade-out complete ho jaye
  final VoidCallback onFinished;
  const SplashScreen({super.key, required this.onFinished});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // ── Intro animations (logo scale + text fade)
  late final AnimationController _introController;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _fadeAnim;

  // ── Fade-out controller (splash fade → reveal dashboard)
  late final AnimationController _fadeOutController;
  late final Animation<double> _screenOpacity;

  @override
  void initState() {
    super.initState();

    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeOutController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _introController, curve: Curves.easeOutBack),
    );

    _fadeAnim = CurvedAnimation(
      parent: _introController,
      curve: Curves.easeIn,
    );

    _screenOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeOutController, curve: Curves.easeOut),
    );

    _introController.forward();
    _bootstrap();
  }

  /// ⚡ Parallel: load assets + wait for dashboard animations to finish
  Future<void> _bootstrap() async {
    // Minimum splash display time (branding)
    final minDelay = Future.delayed(const Duration(milliseconds: 1800));

    final loadTask = () async {
      // 1. Firebase
      try {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
        debugPrint('✅ Firebase initialized');
      } catch (e) {
        debugPrint('❌ Firebase error: $e');
      }

      // 2. Google Fonts (fast if bundled)
      try {
        await GoogleFonts.pendingFonts();
        debugPrint('✅ Fonts ready');
      } catch (e) {
        debugPrint('❌ Fonts error: $e');
      }

      // 3. Precache images
      try {
        if (mounted) {
          await precacheImage(
            const AssetImage('assets/logo/navostudy-logo3.png'),
            context,
          );
          await precacheImage(
            const AssetImage('assets/image/shoolboy.jpg'),
            context,
          );
          debugPrint('✅ Images cached');
        }
      } catch (e) {
        debugPrint('❌ Precache error: $e');
      }
    }();

    // Wait for BOTH
    await Future.wait([minDelay, loadTask]);

    // ⚡ Ensure Dashboard has fully painted at least one frame behind splash
    await SchedulerBinding.instance.endOfFrame;

    // ⚡ Extra buffer — LandingScreen animations (max ~180ms delay + 450ms duration)
    //    need time to complete behind the splash
    await Future.delayed(const Duration(milliseconds: 400));

    if (!mounted) return;

    // 🎬 Fade splash out — reveals fully-loaded dashboard
    await _fadeOutController.forward();

    if (mounted) widget.onFinished();
  }

  @override
  void dispose() {
    _introController.dispose();
    _fadeOutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      // Splash fades → dashboard shows through
      opacity: _screenOpacity,
      child: Scaffold(
        // ⚪ White background
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            // Subtle white → very light blue tint so logo card still pops
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Color(0xFFF3F6FF),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 🎯 Animated logo
                ScaleTransition(
                  scale: _scaleAnim,
                  child: FadeTransition(
                    opacity: _fadeAnim,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        // Light border so card is visible on white bg
                        border: Border.all(
                          color: const Color(0xFF3B66F5).withOpacity(0.15),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            // Soft brand-blue glow instead of black
                            color: const Color(0xFF3B66F5).withOpacity(0.18),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/logo/navostudy-logo3.png',
                        height: 90,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // 📛 App name — dark on white
                FadeTransition(
                  opacity: _fadeAnim,
                  child: Text(
                    "Navo Study",
                    style: GoogleFonts.poppins(
                      color: Colors.black87,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // 💬 Tagline — grey on white
                FadeTransition(
                  opacity: _fadeAnim,
                  child: Text(
                    "Reach Your Target",
                    style: GoogleFonts.poppins(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 48),

                // ⏳ Loader — brand blue on white
                const SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF3B66F5),
                    ),
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