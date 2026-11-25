import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/widget/responsive_font.dart';
import '../../../core/widget/screen_helper.dart';
import '../../enquiry/widget/enquiry_form_card.dart';

// ============================================================
// LANDING SCREEN
// ============================================================

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool _showEnrollForm = false;

  void _toggleEnrollForm() {
    setState(() {
      _showEnrollForm = !_showEnrollForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (ScreenHelper.isDesktop(context)) {
          return _DesktopView(
            showEnrollForm: _showEnrollForm,
            onToggleEnrollForm: _toggleEnrollForm,
          );
        }

        if (ScreenHelper.isTablet(context)) {
          return _TabletView(
            showEnrollForm: _showEnrollForm,
            onToggleEnrollForm: _toggleEnrollForm,
          );
        }

        return _MobileView(
          showEnrollForm: _showEnrollForm,
          onToggleEnrollForm: _toggleEnrollForm,
        );
      },
    );
  }
}

// ============================================================
// HOVER SCALE ANIMATION
// ============================================================

class HoverScale extends StatefulWidget {
  final Widget child;
  final double scale;

  const HoverScale({
    super.key,
    required this.child,
    this.scale = 1.05,
  });

  @override
  State<HoverScale> createState() => _HoverScaleState();
}

class _HoverScaleState extends State<HoverScale> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedScale(
        scale: _hovering ? widget.scale : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

// ============================================================
// DATA LISTS
// ============================================================

final List<Map<String, dynamic>> features = [
  {"icon": Icons.calendar_today_outlined, "title": "50 mock exams"},
  {"icon": Icons.school_outlined, "title": "Guide & Tips"},
  {"icon": Icons.assignment_outlined, "title": "3,000+ sample tests"},
  {"icon": Icons.smart_toy_outlined, "title": "AI-powered scoring"},
];

final List<Map<String, dynamic>> tabs = [
  {
    "icon": Icons.hearing,
    "title": "Listening",
    "color": const Color(0xFFECEFFB),
  },
  {
    "icon": Icons.mic_none,
    "title": "Speaking",
    "color": const Color(0xFFFDF2EB),
  },
  {
    "icon": Icons.edit_outlined,
    "title": "Writing",
    "color": const Color(0xFFE6F7F4),
  },
  {
    "icon": Icons.menu_book_outlined,
    "title": "Reading",
    "color": const Color(0xFFFCEEF3),
  },
  {
    "icon": Icons.analytics_outlined,
    "title": "Mock Exams",
    "color": const Color(0xFFF3EBF9),
  },
];

// ============================================================
// DESKTOP VIEW
// ============================================================

class _DesktopView extends StatelessWidget {
  final bool showEnrollForm;
  final VoidCallback onToggleEnrollForm;

  const _DesktopView({
    required this.showEnrollForm,
    required this.onToggleEnrollForm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 80),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: LandingContent(
                  isCenter: false,
                  showEnrollForm: showEnrollForm,
                  onToggleEnrollForm: onToggleEnrollForm,
                ),
              ),
              const SizedBox(width: 50),
              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: features.map((feature) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: FeatureItem(
                              icon: feature["icon"],
                              title: feature["title"],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const Expanded(
                      child: HeroImage(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 80),
          Row(
            children: tabs.map((tab) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: BottomTabCard(
                    icon: tab["icon"],
                    title: tab["title"],
                    color: tab["color"],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// TABLET VIEW
// ============================================================

class _TabletView extends StatelessWidget {
  final bool showEnrollForm;
  final VoidCallback onToggleEnrollForm;

  const _TabletView({
    required this.showEnrollForm,
    required this.onToggleEnrollForm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
      child: Column(
        children: [
          LandingContent(
            isCenter: true,
            showEnrollForm: showEnrollForm,
            onToggleEnrollForm: onToggleEnrollForm,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: features.map((feature) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: FeatureItem(
                        icon: feature["icon"],
                        title: feature["title"],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const Expanded(
                child: HeroImage(),
              ),
            ],
          ),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            itemCount: tabs.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 1.4,
            ),
            itemBuilder: (context, index) {
              return BottomTabCard(
                icon: tabs[index]["icon"],
                title: tabs[index]["title"],
                color: tabs[index]["color"],
              );
            },
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
  final bool showEnrollForm;
  final VoidCallback onToggleEnrollForm;

  const _MobileView({
    required this.showEnrollForm,
    required this.onToggleEnrollForm,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          LandingContent(
            isCenter: true,
            showEnrollForm: showEnrollForm,
            onToggleEnrollForm: onToggleEnrollForm,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: features.map((feature) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: FeatureItem(
                        icon: feature["icon"],
                        title: feature["title"],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const Expanded(
                child: HeroImage(),
              ),
            ],
          ),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            itemCount: tabs.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              return BottomTabCard(
                icon: tabs[index]["icon"],
                title: tabs[index]["title"],
                color: tabs[index]["color"],
              );
            },
          ),
        ],
      ),
    );
  }
}

// ============================================================
// LANDING CONTENT
// ============================================================

class LandingContent extends StatelessWidget {
  final bool isCenter;
  final bool showEnrollForm;
  final VoidCallback onToggleEnrollForm;

  const LandingContent({
    super.key,
    required this.isCenter,
    required this.showEnrollForm,
    required this.onToggleEnrollForm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        _buildBadge(context),

        const SizedBox(height: 25),

        RichText(
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          text: TextSpan(
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: RFont.size(context, 34, tablet: 42, desktop: 58),
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
            children: const [
              TextSpan(text: "Reach Your Target\n"),
              TextSpan(
                text: "Navo Study",
                style: TextStyle(color: Color(0xFF3B66F5)),
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),

        HoverScale(
          scale: 1.06,
          child: ElevatedButton.icon(
            onPressed: onToggleEnrollForm,
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text("Enroll Now"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B66F5),
              foregroundColor: Colors.white,
              elevation: 0,
              shadowColor: const Color(0xFF3B66F5).withOpacity(0.5),
              padding: const EdgeInsets.symmetric(
                horizontal: 26,
                vertical: 20,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),

        // 🔹 Animated form – uses the separated EnquiryFormCard
        AnimatedCrossFade(
          firstChild: const SizedBox(height: 0, width: double.infinity),
          secondChild: const Padding(
            padding: EdgeInsets.only(top: 24),
            child: EnquiryFormCard(),
          ),
          crossFadeState: showEnrollForm
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 400),
          sizeCurve: Curves.easeInOut,
        ),

        const SizedBox(height: 24),

        Row(
          mainAxisAlignment:
          isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.workspace_premium,
              color: Colors.orange,
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              "Top Rated Navo Study Resource 2026",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
                fontSize: RFont.size(context, 12, tablet: 14, desktop: 13),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF07E3F),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: List.generate(
              3,
                  (index) => Container(
                margin: const EdgeInsets.only(right: 4),
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white24,
                ),
                child: const Icon(
                  Icons.person,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "Trusted by 10k+ test-takers",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: RFont.size(context, 12, tablet: 14, desktop: 14),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// FEATURE ITEM - HOVER ANIMATION
// ============================================================

class FeatureItem extends StatefulWidget {
  final IconData icon;
  final String title;

  const FeatureItem({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  State<FeatureItem> createState() => _FeatureItemState();
}

class _FeatureItemState extends State<FeatureItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.basic,
      child: AnimatedSlide(
        offset: _hovering ? const Offset(0.03, 0) : Offset.zero,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: _hovering ? 1.18 : 1.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              child: Icon(
                widget.icon,
                size: 22,
                color: _hovering
                    ? const Color(0xFF3B66F5)
                    : Colors.black87,
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                widget.title,
                style: TextStyle(
                  color: _hovering
                      ? const Color(0xFF3B66F5)
                      : Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: RFont.size(context, 14, tablet: 16, desktop: 18),
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
// HERO IMAGE - FLOATING ANIMATION
// ============================================================

class HeroImage extends StatefulWidget {
  const HeroImage({super.key});

  @override
  State<HeroImage> createState() => _HeroImageState();
}

class _HeroImageState extends State<HeroImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _float;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _float = Tween<double>(begin: -8, end: 8).animate(
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
        height: ScreenHelper.isMobile(context) ? 300 : 350,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage('assets/image/shoolboy.jpg'),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// BOTTOM TAB CARD - HOVER ANIMATION
// ============================================================

class BottomTabCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final Color color;

  const BottomTabCard({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  State<BottomTabCard> createState() => _BottomTabCardState();
}

class _BottomTabCardState extends State<BottomTabCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedSlide(
        offset: _hovering ? const Offset(0, -0.05) : Offset.zero,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovering
                  ? widget.color.withOpacity(0.7)
                  : Colors.grey,
              width: _hovering ? 1.2 : 0.3,
            ),
            boxShadow: [
              BoxShadow(
                color: _hovering
                    ? widget.color.withOpacity(0.3)
                    : Colors.black.withOpacity(0.03),
                blurRadius: _hovering ? 20 : 12,
                offset: Offset(0, _hovering ? 12 : 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: widget.color,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.icon,
                  color: Colors.black,
                  size: RFont.size(context, 14, tablet: 16, desktop: 20),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: RFont.size(context, 10, tablet: 14, desktop: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}