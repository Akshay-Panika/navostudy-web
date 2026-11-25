import 'package:navostudy/core/widget/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/widget/screen_helper.dart';
import '../../abouts/screen/about_screen.dart';
import '../../apply/screen/apply_screen.dart';
import '../../batch/screen/batch_screen.dart';
import '../../footer/screen/footer_screen.dart';
import '../../home/screen/home_screen.dart';
import '../../practice_overview/screen/practice_overview_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  /// MOBILE MENU
  bool isMenuOpen = false;

  /// SCROLL CONTROLLER
  final ScrollController _scrollController = ScrollController();

  /// FOOTER KEY
  final GlobalKey footerKey = GlobalKey();

  /// 0 = Home | 1 = About | 2 = Practice | 3 = Batch | 4 = Apply
  final List<Widget> navScreen = const [
    HomeScreen(),
    AboutScreen(),
    PracticeOverviewScreen(),
    BatchScreen(),
    ApplyScreen(),
  ];

  /// SCROLL TO TOP
  void scrollTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  /// SCROLL TO FOOTER
  void scrollToFooter() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = footerKey.currentContext;

      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Widget navButton(String title, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: RFont.size(context, 12, tablet: 12, desktop: 14),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = ScreenHelper.isDesktop(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          /// APP BAR
          SliverAppBar(
            floating: true,
            toolbarHeight: isMenuOpen && !isDesktop ? 440 : 80,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 100 : 12,
                  vertical: 10,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B66F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: isMenuOpen
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: [
                    if (isMenuOpen) const SizedBox(height: 14),

                    /// TOP NAVBAR
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// LOGO
                        Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.blue,width: 0.3)
                                ),
                                child: Image.asset('assets/logo/navostudy-logo3.png',height: 45,)),
                          ],
                        ),

                        /// DESKTOP MENU
                        if (isDesktop)
                          Row(
                            children: [
                              navButton("Home", () {
                                setState(() => selectedIndex = 0);
                                scrollTop();
                              }),
                              navButton("About Us", () {
                                setState(() => selectedIndex = 1);
                                scrollTop();
                              }),
                              navButton("Practice Overview", () {
                                setState(() => selectedIndex = 2);
                                scrollTop();
                              }),
                              navButton("Batch", () {
                                setState(() => selectedIndex = 3);
                                scrollTop();
                              }),
                              navButton("Contact Us", () {
                                setState(() => selectedIndex = 0);
                                scrollToFooter();
                              }),
                            ],
                          ),

                        Row(
                          spacing: 20,
                          children: [
                            if (!ScreenHelper.isMobile(context))
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.blue,
                                ),
                                onPressed: () {
                                  setState(() => selectedIndex = 4);
                                  scrollTop();
                                },
                                child: Text(
                                  "Sign In/Sign Up",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF3B66F5),
                                    fontSize: RFont.size(
                                      context,
                                      12,
                                      tablet: 12,
                                      desktop: 12,
                                    ),
                                  ),
                                ),
                              ),

                            if (!isDesktop)
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.blue,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isMenuOpen = !isMenuOpen;
                                  });
                                },
                                child: Icon(
                                  isMenuOpen ? Icons.close : Icons.menu,
                                  color: const Color(0xFF3B66F5),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),

                    /// MOBILE DROPDOWN MENU
                    if (!isDesktop && isMenuOpen)
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          children: [
                            mobileMenuButton(
                              title: "Home",
                              onTap: () {
                                setState(() {
                                  selectedIndex = 0;
                                  isMenuOpen = false;
                                });
                                scrollTop();
                              },
                            ),
                            mobileMenuButton(
                              title: "About Us",
                              onTap: () {
                                setState(() {
                                  selectedIndex = 1;
                                  isMenuOpen = false;
                                });
                                scrollTop();
                              },
                            ),
                            mobileMenuButton(
                              title: "Practice Overview",
                              onTap: () {
                                setState(() {
                                  selectedIndex = 2;
                                  isMenuOpen = false;
                                });
                                scrollTop();
                              },
                            ),

                            /// BATCH (NEW)
                            mobileMenuButton(
                              title: "Batch",
                              onTap: () {
                                setState(() {
                                  selectedIndex = 3;
                                  isMenuOpen = false;
                                });
                                scrollTop();
                              },
                            ),

                            mobileMenuButton(
                              title: "Contact Us",
                              onTap: () {
                                setState(() {
                                  selectedIndex = 0;
                                  isMenuOpen = false;
                                });
                                scrollToFooter();
                              },
                            ),

                            mobileMenuButton(
                              title: "Sign In/Sign Up",
                              onTap: () {
                                setState(() {
                                  selectedIndex = 4;
                                  isMenuOpen = false;
                                });
                                scrollTop();
                              },
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

          /// BODY
          SliverToBoxAdapter(
            child: Column(
              children: [
                navScreen[selectedIndex],

                /// FOOTER
                Container(
                  key: footerKey,
                  child: const FooterScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// MOBILE MENU BUTTON
  Widget mobileMenuButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}