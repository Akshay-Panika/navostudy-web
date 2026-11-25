import 'package:navostudy/core/widget/responsive_font.dart';
import 'package:navostudy/core/widget/screen_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// 🔹 EnquiryFormCard ka import add karo (apne folder structure ke hisab se path check kar lena)
import '../../enquiry/widget/enquiry_form_card.dart';

// 🔴 Converted to StatefulWidget to manage Demo Form state
class PackageScreen extends StatefulWidget {
  const PackageScreen({super.key});

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  bool _showEnrollForm = false;

  void _toggleEnrollForm() {
    setState(() {
      _showEnrollForm = !_showEnrollForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = ScreenHelper.isDesktop(context);
    final double horizontalPadding = isDesktop ? 100.0 : 20.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 40),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 50.0 : 14.0,
                        vertical: isDesktop ? 50.0 : 16.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B66F5),
                        borderRadius: BorderRadius.circular(24), // Smooth layout curves
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildLeftContent(context, isDesktop),
                          const Spacer(flex: 4),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: isDesktop ? 40 : 0,
                bottom: -12,
                top: -40,
                child: Image.asset(
                  'assets/image/shoolboy.jpg',
                  fit: BoxFit.contain,
                  errorBuilder: (c, e, s) => const _MascotPlaceholder(),
                ),
              ),
            ],
          ),

          /// 🟢 ANIMATED ENROLL FORM (Niche expand hoga)
          AnimatedCrossFade(
            firstChild: const SizedBox(height: 0, width: double.infinity),
            secondChild: const Padding(
              padding: EdgeInsets.only(top: 30),
              // 🔹 Yahan naya EnquiryFormCard call kiya hai
              child: EnquiryFormCard(),
            ),
            crossFadeState: _showEnrollForm
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 400),
            sizeCurve: Curves.easeInOut,
          ),
        ],
      ),
    );
  }

  Widget _buildLeftContent(BuildContext context, bool isDesktop) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Heading Text
          Text(
            "The Best Practice Exercises for Navo Study Exam Preparation",
            textAlign: TextAlign.start,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: RFont.size(context, 12, tablet: 14, desktop: 16),
            ),
          ),
          const SizedBox(height: 35),

          Flex(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            direction:
            ScreenHelper.isDesktop(context) ? Axis.horizontal : Axis.vertical,
            children: [
              // ✅ Start Your Free Practice Button
              ElevatedButton(
                onPressed: _toggleEnrollForm, // Toggles the form
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add, color: Color(0xFFFA5222), size: 18),
                    const SizedBox(width: 6),
                    Text(
                      "Enroll Now",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF1E293B),
                        fontWeight: FontWeight.w600,
                        fontSize: RFont.size(context, 12, tablet: 14, desktop: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Fallback error placeholder widget
class _MascotPlaceholder extends StatelessWidget {
  const _MascotPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: const Icon(Icons.face, size: 60, color: Colors.white),
    );
  }
}