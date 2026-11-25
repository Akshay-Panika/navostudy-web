import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../core/widget/responsive_font.dart';
import '../../../core/widget/screen_helper.dart';

class TestimonialsScreen extends StatelessWidget {
  const TestimonialsScreen({super.key});

  final List<Map<String, dynamic>> _reviews = const [
    {
      "name": "Carlos Mendoza",
      "rating": 5,
      "comment":
      "CLPIP.com made a huge difference for me. The speaking practice and instant feedback gave me confidence. I passed with 9 in all sections!"
    },
    {
      "name": "Li Wei",
      "rating": 5,
      "comment":
      "The speaking section on this website is amazing. I recorded my answers and compared with high-score samples. It helped a lot."
    },
    {
      "name": "Tatiana Volkov",
      "rating": 5,
      "comment":
      "Simple and powerful. I used it for a month and improved in all 4 sections. The dashboard tracking my progress was a nice bonus."
    },
    {
      "name": "Ahmed El-Sayed",
      "rating": 5,
      "comment":
      "I finally got CLB 9 in writing after using CLPIP.com for two weeks. The AI feedback was exactly what I needed to improve structure and coherence. Highly recommend it!"
    },
    {
      "name": "Dalia Haddad",
      "rating": 5,
      "comment":
      "So many useful strategies I learned from the reading section. The mock tests are challenging but realistic. Helped calm my anxiety."
    }
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = ScreenHelper.isDesktop(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80.0 : 20.0,
        vertical: 60.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Join 20,000+ Students Who Trust Us",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF1E293B),
              fontWeight: FontWeight.bold,
              fontSize: RFont.size(context, 18, tablet: 20, desktop: 30),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 50),

          isDesktop
              ? _buildDesktopLayout()
              : _buildMobileAndTabletLayout(context),
        ],
      ),
    );
  }

  /// ================= DESKTOP (tilt layout + hover) =================
  Widget _buildDesktopLayout() {
    return Column(
      children: [
        // Top Row: 3 straight cards
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _HoverLiftCard(
                child: _ReviewCard(review: _reviews[0]),
              ),
            ),
            const SizedBox(width: 25),
            Expanded(
              child: _HoverLiftCard(
                child: _ReviewCard(review: _reviews[1]),
              ),
            ),
            const SizedBox(width: 25),
            Expanded(
              child: _HoverLiftCard(
                child: _ReviewCard(review: _reviews[2]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),

        // Bottom Row: 2 tilted cards
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: _FloatingTilt(
                  angleDegrees: -6,
                  floatPhase: 0.0,
                  child: _HoverLiftCard(
                    child: _ReviewCard(review: _reviews[3]),
                  ),
                ),
              ),
              const SizedBox(width: 80),
              Expanded(
                child: _FloatingTilt(
                  angleDegrees: 5,
                  floatPhase: 0.5,
                  child: _HoverLiftCard(
                    child: _ReviewCard(review: _reviews[4]),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  /// ================= MOBILE / TABLET =================
  Widget _buildMobileAndTabletLayout(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _reviews.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: _HoverLiftCard(
            child: _ReviewCard(review: _reviews[index]),
          ),
        );
      },
    );
  }
}

// ============================================================
// 🖱️ HOVER LIFT (adds lift + scale on hover)
// ============================================================
class _HoverLiftCard extends StatefulWidget {
  final Widget child;
  const _HoverLiftCard({required this.child});

  @override
  State<_HoverLiftCard> createState() => _HoverLiftCardState();
}

class _HoverLiftCardState extends State<_HoverLiftCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.basic,
      child: AnimatedSlide(
        offset: _hovering ? const Offset(0, -0.03) : Offset.zero,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        child: AnimatedScale(
          scale: _hovering ? 1.015 : 1.0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          child: widget.child,
        ),
      ),
    );
  }
}

// ============================================================
// 🌊 FLOATING TILT (gentle float for slanted cards)
// ============================================================
class _FloatingTilt extends StatefulWidget {
  final Widget child;
  final double angleDegrees;
  final double floatPhase;

  const _FloatingTilt({
    required this.child,
    required this.angleDegrees,
    this.floatPhase = 0.0,
  });

  @override
  State<_FloatingTilt> createState() => _FloatingTiltState();
}

class _FloatingTiltState extends State<_FloatingTilt>
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

    _float = Tween<double>(begin: -4, end: 4).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          widget.floatPhase * 0.5,
          1.0,
          curve: Curves.easeInOut,
        ),
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
          child: Transform.rotate(
            angle: widget.angleDegrees * (math.pi / 180),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

// ============================================================
// 🃏 REVIEW CARD (hover: golden border + star pop + avatar rotate)
// ============================================================
class _ReviewCard extends StatefulWidget {
  final Map<String, dynamic> review;
  const _ReviewCard({required this.review});

  @override
  State<_ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<_ReviewCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovering
                ? const Color(0xFFFFC107).withOpacity(0.4)
                : Colors.transparent,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovering
                  ? Colors.black.withOpacity(0.08)
                  : Colors.black.withOpacity(0.04),
              blurRadius: _hovering ? 32 : 24,
              offset: Offset(0, _hovering ? 18 : 12),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header: avatar + name + stars
            Row(
              children: [
                // Avatar with rotate + scale on hover
                AnimatedRotation(
                  turns: _hovering ? 0.03 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  child: AnimatedScale(
                    scale: _hovering ? 1.08 : 1.0,
                    duration: const Duration(milliseconds: 250),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blueGrey.shade100,
                      child: const Icon(
                        Icons.person,
                        color: Colors.blueGrey,
                        size: 22,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.review['name'],
                        style: const TextStyle(
                          color: Color(0xFF1E293B),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 3),

                      // ⭐ Staggered star pop on hover
                      Row(
                        children: List.generate(
                          widget.review['rating'] as int,
                              (index) => TweenAnimationBuilder<double>(
                            tween: Tween(
                              begin: 1.0,
                              end: _hovering ? 1.25 : 1.0,
                            ),
                            duration: Duration(
                              milliseconds: 200 + (index * 60),
                            ),
                            curve: Curves.easeOutBack,
                            builder: (context, scale, child) {
                              return Transform.scale(
                                scale: scale,
                                child: child,
                              );
                            },
                            child: const Icon(
                              Icons.star_rounded,
                              color: Color(0xFFFFC107),
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Comment
            Text(
              widget.review['comment'],
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: RFont.size(context, 13.5, desktop: 14),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}