import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/widget/responsive_font.dart';
import '../../../core/widget/screen_helper.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFF),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              if (ScreenHelper.isDesktop(context) ||
                  ScreenHelper.isTablet(context)) {
                return const _DesktopView();
              }

              return const _MobileView();
            },
          ),

          // BOTTOM STATS SECTION
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 40,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35),
            ),
            child: Column(
              children: [
                Text(
                  "Trusted By Thousands Of Students",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: RFont.size(
                      context,
                      22,
                      tablet: 28,
                      desktop: 34,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                Text(
                  "Learn smarter with live tests, rankings and scholarship opportunities.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.black54,
                    height: 1.7,
                    fontSize: RFont.size(
                      context,
                      13,
                      tablet: 14,
                      desktop: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                ScreenHelper.isDesktop(context)
                    ? Row(
                  children: [
                    Expanded(
                      child: _AnimatedInfoCard(
                        value: "15K+",
                        title: "Active Students",
                        icon: Icons.groups_rounded,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _AnimatedInfoCard(
                        value: "120+",
                        title: "Mock Tests",
                        icon: Icons.menu_book_rounded,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _AnimatedInfoCard(
                        value: "98%",
                        title: "Success Rate",
                        icon: Icons.emoji_events_rounded,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _AnimatedInfoCard(
                        value: "24/7",
                        title: "Learning Support",
                        icon: Icons.support_agent_rounded,
                      ),
                    ),
                  ],
                )
                    : GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.2,
                  children: const [
                    _AnimatedInfoCard(
                      value: "15K+",
                      title: "Active Students",
                      icon: Icons.groups_rounded,
                    ),
                    _AnimatedInfoCard(
                      value: "120+",
                      title: "Mock Tests",
                      icon: Icons.menu_book_rounded,
                    ),
                    _AnimatedInfoCard(
                      value: "98%",
                      title: "Success Rate",
                      icon: Icons.emoji_events_rounded,
                    ),
                    _AnimatedInfoCard(
                      value: "24/7",
                      title: "Learning Support",
                      icon: Icons.support_agent_rounded,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

// ============================================================
// FLOATING IMAGE ANIMATION
// ============================================================

class _FloatingImage extends StatefulWidget {
  final double height;
  final bool isDesktop;

  const _FloatingImage({
    required this.height,
    this.isDesktop = false,
  });

  @override
  State<_FloatingImage> createState() => _FloatingImageState();
}

class _FloatingImageState extends State<_FloatingImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _float;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _float = Tween<double>(
      begin: -8,
      end: 8,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _float,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _float.value),
          child: child,
        );
      },
      child: Container(
        height: widget.height,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: const DecorationImage(
            image: AssetImage("assets/image/shoolboy.jpg"),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// ANIMATED HOVER CARD
// ============================================================

class _AnimatedInfoCard extends StatefulWidget {
  final String value;
  final String title;
  final IconData icon;

  const _AnimatedInfoCard({
    required this.value,
    required this.title,
    required this.icon,
  });

  @override
  State<_AnimatedInfoCard> createState() => _AnimatedInfoCardState();
}

class _AnimatedInfoCardState extends State<_AnimatedInfoCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..translate(0.0, _hovering ? -8.0 : 0.0)
          ..scale(_hovering ? 1.025 : 1.0),
        transformAlignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _hovering
                ? const Color(0xFF3B66F5).withOpacity(0.5)
                : Colors.black12,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                _hovering ? 0.09 : 0.02,
              ),
              blurRadius: _hovering ? 25 : 10,
              offset: Offset(0, _hovering ? 12 : 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF3B66F5).withOpacity(
                  _hovering ? 0.18 : 0.1,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: AnimatedRotation(
                turns: _hovering ? 0.08 : 0,
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOut,
                child: Icon(
                  widget.icon,
                  color: const Color(0xFF3B66F5),
                  size: 28,
                ),
              ),
            ),

            const SizedBox(height: 24),

            AnimatedScale(
              scale: _hovering ? 1.1 : 1,
              duration: const Duration(milliseconds: 250),
              child: Text(
                widget.value,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: RFont.size(
                    context,
                    16,
                    tablet: 16,
                    desktop: 18,
                  ),
                ),
              ),
            ),

            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                fontSize: RFont.size(
                  context,
                  12,
                  tablet: 14,
                  desktop: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// DESKTOP / TABLET VIEW
// ============================================================

class _DesktopView extends StatelessWidget {
  const _DesktopView();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 80,
        vertical: 70,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: _FloatingImage(
              height: 520,
              isDesktop: true,
            ),
          ),

          const SizedBox(width: 70),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                Text(
                  "Empowering Students\nWith Smart Learning",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    fontSize: RFont.size(
                      context,
                      32,
                      tablet: 42,
                      desktop: 56,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  "Navo Study helps students prepare for exams, "
                      "practice mock tests, improve rankings and unlock "
                      "new learning opportunities through smart digital education.",
                  style: GoogleFonts.poppins(
                    color: Colors.black54,
                    height: 1.8,
                    fontSize: RFont.size(
                      context,
                      14,
                      tablet: 15,
                      desktop: 17,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFeature(
                      context,
                      Icons.check_circle,
                      "Live Practice Tests",
                    ),
                    const SizedBox(height: 18),
                    _buildFeature(
                      context,
                      Icons.check_circle,
                      "Real-Time Rankings",
                    ),
                    const SizedBox(height: 18),
                    _buildFeature(
                      context,
                      Icons.check_circle,
                      "Scholarship Opportunities",
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                const _AnimatedLearnMoreButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// MOBILE VIEW
// ============================================================

class _MobileView extends StatelessWidget {
  const _MobileView();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _FloatingImage(height: 250),

            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF3B66F5),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "About Us",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: RFont.size(context, 12),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              "Empowering Students\nWith Smart Learning",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                height: 1.2,
                fontSize: RFont.size(context, 34),
              ),
            ),

            const SizedBox(height: 18),

            Text(
              "Navo Study helps students prepare for exams, "
                  "practice tests and improve performance with "
                  "smart digital learning.",
              style: GoogleFonts.poppins(
                color: Colors.black54,
                height: 1.7,
                fontSize: RFont.size(context, 14),
              ),
            ),

            const SizedBox(height: 30),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFeature(
                  context,
                  Icons.check_circle,
                  "Live Practice Tests",
                ),
                const SizedBox(height: 15),
                _buildFeature(
                  context,
                  Icons.check_circle,
                  "Real-Time Rankings",
                ),
                const SizedBox(height: 15),
                _buildFeature(
                  context,
                  Icons.check_circle,
                  "Scholarship Opportunities",
                ),
              ],
            ),

            const SizedBox(height: 35),

            const _AnimatedLearnMoreButton(),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// ANIMATED BUTTON
// ============================================================

class _AnimatedLearnMoreButton extends StatefulWidget {
  const _AnimatedLearnMoreButton();

  @override
  State<_AnimatedLearnMoreButton> createState() =>
      _AnimatedLearnMoreButtonState();
}

class _AnimatedLearnMoreButtonState
    extends State<_AnimatedLearnMoreButton> {
  bool _hovering = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() {
        _hovering = false;
        _pressed = false;
      }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedScale(
          scale: _pressed ? 0.96 : (_hovering ? 1.04 : 1),
          duration: const Duration(milliseconds: 180),
          child: SizedBox(
            width: ScreenHelper.isDesktop(context)
                ? null
                : double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B66F5),
                foregroundColor: Colors.white,
                elevation: _hovering ? 8 : 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {},
              child: Text(
                "Learn More",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// FEATURE TILE
// ============================================================

Widget _buildFeature(
    BuildContext context,
    IconData icon,
    String title,
    ) {
  return Row(
    children: [
      Icon(
        icon,
        color: const Color(0xFF3B66F5),
        size: 24,
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: RFont.size(
              context,
              14,
              tablet: 15,
              desktop: 16,
            ),
          ),
        ),
      ),
    ],
  );
}