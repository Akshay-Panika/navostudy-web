import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart'; // ✅ Added for form submission
import 'package:navostudy/core/widget/responsive_font.dart';
import 'package:navostudy/core/widget/screen_helper.dart';
import '../../../core/utils/app_color.dart';

// =========================================================
// DUMMY TRAINER DATA
// =========================================================
final List<Map<String, String>> dummyTrainers = [
  {
    "name": "Shreyansh Gupta",
    "exp": "10+ Years Experience",
    "role": "Navodaya Specialist",
    "bio": "Expert in JNVST Mental Ability and Arithmetic. Has guided over 5000+ students to clear the entrance exam with top ranks.",
  },
  {
    "name": "Krishnakant Jatav",
    "exp": "8+ Years Experience",
    "role": "Maths Expert",
    "bio": "Specializes in logical reasoning and math shortcuts. Known for making complex topics easy for Class 6 students.",
  },
  {
    "name": "Akshay Panika",
    "exp": "5+ Years Experience",
    "role": "Language Expert",
    "bio": "Focuses on grammar and reading comprehension. Believes in interactive learning and daily practice.",
  },
];

// =========================================================
// 1. PRACTICE OVERVIEW SCREEN (MAIN)
// =========================================================
class PracticeOverviewScreen extends StatefulWidget {
  const PracticeOverviewScreen({super.key});

  @override
  State<PracticeOverviewScreen> createState() => _PracticeOverviewScreenState();
}

class _PracticeOverviewScreenState extends State<PracticeOverviewScreen> {
  bool _showResults = false;
  bool _showEnrollForm = false;

  void _toggleResults() {
    setState(() {
      _showResults = !_showResults;
      if (_showResults) _showEnrollForm = false;
    });
  }

  void _toggleEnrollForm() {
    setState(() {
      _showEnrollForm = !_showEnrollForm;
      if (_showEnrollForm) _showResults = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            /// DESKTOP + TABLET SAME LAYOUT
            if (ScreenHelper.isDesktop(context) ||
                ScreenHelper.isTablet(context)) {
              return _DesktopView(
                showResults: _showResults,
                onToggleResults: _toggleResults,
                showEnrollForm: _showEnrollForm,
                onToggleEnrollForm: _toggleEnrollForm,
              );
            }

            /// MOBILE LAYOUT
            return _MobileView(
              showResults: _showResults,
              onToggleResults: _toggleResults,
              showEnrollForm: _showEnrollForm,
              onToggleEnrollForm: _toggleEnrollForm,
            );
          },
        ),
        const LearnPage()
      ],
    );
  }
}

/// ===============================
/// TOP STUDENTS DUMMY DATA & WIDGET
/// ===============================
final List<Map<String, dynamic>> _topStudents = [
  {"name": "Aarav Sharma", "rank": 1, "score": "98.5%"},
  {"name": "Priya Patel", "rank": 2, "score": "97.2%"},
  {"name": "Rohan Verma", "rank": 3, "score": "96.8%"},
  {"name": "Sneha Gupta", "rank": 4, "score": "95.5%"},
  {"name": "Vikram Singh", "rank": 5, "score": "94.9%"},
];

Widget _buildTopStudentsSection(BuildContext context) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 24, bottom: 24),
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: const Color(0xFF3B66F5).withOpacity(0.3), width: 2),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF3B66F5).withOpacity(0.08),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF07E3F).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.emoji_events, color: Color(0xFFF07E3F), size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                "Top 5 Selected Students (JNVST)",
                style: GoogleFonts.poppins(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: RFont.size(context, 20, tablet: 22, desktop: 24),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Divider(),
        const SizedBox(height: 10),

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _topStudents.length,
          separatorBuilder: (context, index) => const Divider(height: 20, color: Colors.black12),
          itemBuilder: (context, index) {
            final student = _topStudents[index];
            return Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: student['rank'] == 1
                        ? const Color(0xFFFFD700).withOpacity(0.2)
                        : student['rank'] == 2
                        ? const Color(0xFFC0C0C0).withOpacity(0.3)
                        : student['rank'] == 3
                        ? const Color(0xFFCD7F32).withOpacity(0.2)
                        : const Color(0xFF3B66F5).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    "#${student['rank']}",
                    style: GoogleFonts.poppins(
                      color: student['rank'] <= 3 ? Colors.black87 : const Color(0xFF3B66F5),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student['name'],
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: RFont.size(context, 16, tablet: 17, desktop: 18),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(Icons.verified, color: Color(0xFF4CAF50), size: 14),
                          const SizedBox(width: 4),
                          Text(
                            "Selected",
                            style: GoogleFonts.poppins(
                              color: Colors.grey.shade600,
                              fontSize: RFont.size(context, 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    student['score'],
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF4CAF50),
                      fontWeight: FontWeight.bold,
                      fontSize: RFont.size(context, 13, tablet: 14, desktop: 15),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    ),
  );
}

/// ===============================
/// DESKTOP VIEW (Practice Overview)
/// ===============================
class _DesktopView extends StatelessWidget {
  final bool showResults;
  final VoidCallback onToggleResults;
  final bool showEnrollForm;
  final VoidCallback onToggleEnrollForm;

  const _DesktopView({
    required this.showResults,
    required this.onToggleResults,
    required this.showEnrollForm,
    required this.onToggleEnrollForm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenHelper.isTablet(context) ? 30 : 100,
          vertical: 80,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// LEFT SIDE
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF07E3F),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "JNVST Practice",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: RFont.size(context, 12, tablet: 13, desktop: 14),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      Text(
                        "Prepare For\nJNVST 2027 (Class 6 & 9)",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: RFont.size(context, 34, tablet: 42, desktop: 50),
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 20),

                      SizedBox(
                        width: 600,
                        child: Text(
                          "Practice class-wise JNVST mock tests, improve your ranking "
                              "and unlock free education opportunities by scoring high "
                              "in our Jawahar Navodaya Vidyalaya selection practice tests.",
                          style: GoogleFonts.poppins(
                            color: Colors.black54,
                            fontSize: RFont.size(context, 14, tablet: 15, desktop: 17),
                            height: 1.8,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3B66F5),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                            onPressed: onToggleEnrollForm,
                            child: Text(
                              "Start Practice",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(width: 20),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.black12),
                              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                            onPressed: onToggleResults,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  showResults ? "Hide Results" : "View Results",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: RFont.size(context, 12, tablet: 14, desktop: 16),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                AnimatedRotation(
                                  turns: showResults ? 0.5 : 0.0,
                                  duration: const Duration(milliseconds: 300),
                                  child: const Icon(Icons.keyboard_arrow_down, size: 20),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      AnimatedCrossFade(
                        firstChild: const SizedBox(height: 0, width: double.infinity),
                        secondChild: Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: _DemoRegistrationForm(),
                        ),
                        crossFadeState: showEnrollForm ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 400),
                        sizeCurve: Curves.easeInOut,
                      ),

                      const SizedBox(height: 60),

                      Row(
                        children: [
                          Expanded(child: _buildStatCard(context, "15K+", "Students")),
                          const SizedBox(width: 20),
                          Expanded(child: _buildStatCard(context, "120+", "Mock Tests")),
                          const SizedBox(width: 20),
                          Expanded(child: _buildStatCard(context, "98%", "Success Rate")),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 60),

                /// RIGHT SIDE - VIDEO FRAME
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 350,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF3B66F5).withOpacity(0.1),
                              const Color(0xFF3B66F5).withOpacity(0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFF3B66F5).withOpacity(0.2), width: 2),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 10)),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.asset(
                                'assets/image/shoolboy.jpg',
                                height: 350,
                                width: 300,
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: const Color(0xFF3B66F5).withOpacity(0.1),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.play_circle_filled, size: 80, color: const Color(0xFF3B66F5).withOpacity(0.5)),
                                        const SizedBox(height: 16),
                                        Text("JNVST 2027 Guide", style: GoogleFonts.poppins(color: const Color(0xFF3B66F5), fontSize: 18, fontWeight: FontWeight.w600)),
                                        Text("Crack Navodaya!", style: GoogleFonts.poppins(color: Colors.grey.shade600, fontSize: 14)),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20, spreadRadius: 5)],
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.play_arrow, color: Color(0xFF3B66F5), size: 60),
                                style: IconButton.styleFrom(backgroundColor: Colors.white, padding: const EdgeInsets.all(16), shape: const CircleBorder()),
                              ),
                            ),
                            Positioned(
                              bottom: 16,
                              right: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(color: Colors.black.withOpacity(0.7), borderRadius: BorderRadius.circular(6)),
                                child: Row(
                                  children: [
                                    const Icon(Icons.access_time, color: Colors.white, size: 14),
                                    const SizedBox(width: 4),
                                    Text("2:30", style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 16,
                              left: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.2)],
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text("How to Crack JNVST 2027", style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(color: const Color(0xFF3B66F5).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                              child: const Icon(Icons.info_outline, color: Color(0xFF3B66F5), size: 20),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "Watch this short video to understand the JNVST 2027 exam pattern, syllabus, and how our practice sets can help you crack it.",
                                style: GoogleFonts.poppins(color: Colors.grey.shade700, fontSize: 13, height: 1.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            AnimatedCrossFade(
              firstChild: const SizedBox(height: 0, width: double.infinity),
              secondChild: _buildTopStudentsSection(context),
              crossFadeState: showResults ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 400),
              sizeCurve: Curves.easeInOut,
            ),
          ],
        ),
      ),
    );
  }
}

/// ===============================
/// MOBILE VIEW (Practice Overview)
/// ===============================
class _MobileView extends StatelessWidget {
  final bool showResults;
  final VoidCallback onToggleResults;
  final bool showEnrollForm;
  final VoidCallback onToggleEnrollForm;

  const _MobileView({
    required this.showResults,
    required this.onToggleResults,
    required this.showEnrollForm,
    required this.onToggleEnrollForm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(color: const Color(0xFFF07E3F), borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "JNVST Practice",
                  style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: RFont.size(context, 12, tablet: 13, desktop: 14)),
                ),
              ),
              const SizedBox(height: 25),

              Text(
                "Prepare For\nJNVST 2027 (Class 6 & 9)",
                style: GoogleFonts.poppins(color: Colors.black, fontSize: RFont.size(context, 34, tablet: 42, desktop: 58), fontWeight: FontWeight.bold, height: 1.2),
              ),
              const SizedBox(height: 20),

              Text(
                "Practice JNVST mock tests, improve your rank, and unlock free education opportunities.",
                style: GoogleFonts.poppins(color: Colors.black54, fontSize: RFont.size(context, 14, tablet: 15, desktop: 17), height: 1.7),
              ),
              const SizedBox(height: 35),

              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [const Color(0xFF3B66F5).withOpacity(0.1), const Color(0xFF3B66F5).withOpacity(0.05)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF3B66F5).withOpacity(0.2), width: 2),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 15, offset: const Offset(0, 8))],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(
                        'assets/image/shoolboy.jpg',
                        height: 200,
                        width: 200,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFF3B66F5).withOpacity(0.1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.play_circle_filled, size: 50, color: const Color(0xFF3B66F5).withOpacity(0.5)),
                                const SizedBox(height: 8),
                                Text("Crack Navodaya!", style: GoogleFonts.poppins(color: const Color(0xFF3B66F5), fontSize: 14, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 15, spreadRadius: 3)]),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.play_arrow, color: Color(0xFF3B66F5), size: 40),
                        style: IconButton.styleFrom(backgroundColor: Colors.white, padding: const EdgeInsets.all(12), shape: const CircleBorder()),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.7), borderRadius: BorderRadius.circular(4)),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time, color: Colors.white, size: 12),
                            const SizedBox(width: 4),
                            Text("2:30", style: GoogleFonts.poppins(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(color: const Color(0xFF3B66F5).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                      child: const Icon(Icons.info_outline, color: Color(0xFF3B66F5), size: 16),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Watch this short video to understand the JNVST 2027 exam pattern and how to prepare.",
                        style: GoogleFonts.poppins(color: Colors.grey.shade700, fontSize: 12, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B66F5),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: onToggleEnrollForm,
                    child: Text("Start Practice", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(width: 20),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black12),
                      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: onToggleResults,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          showResults ? "Hide Results" : "View Results",
                          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: RFont.size(context, 12, tablet: 14, desktop: 16)),
                        ),
                        const SizedBox(width: 8),
                        AnimatedRotation(
                          turns: showResults ? 0.5 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: const Icon(Icons.keyboard_arrow_down, size: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              AnimatedCrossFade(
                firstChild: const SizedBox(height: 0, width: double.infinity),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: _DemoRegistrationForm(),
                ),
                crossFadeState: showEnrollForm ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 400),
                sizeCurve: Curves.easeInOut,
              ),

              const SizedBox(height: 35),

              Row(
                children: [
                  Expanded(child: _buildStatCard(context, "15K+", "Students")),
                  const SizedBox(width: 12),
                  Expanded(child: _buildStatCard(context, "120+", "Tests")),
                  const SizedBox(width: 12),
                  Expanded(child: _buildStatCard(context, "98%", "Success")),
                ],
              ),

              AnimatedCrossFade(
                firstChild: const SizedBox(height: 0, width: double.infinity),
                secondChild: _buildTopStudentsSection(context),
                crossFadeState: showResults ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 400),
                sizeCurve: Curves.easeInOut,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildStatCard(BuildContext context, String value, String title) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.black12),
    ),
    child: Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold, fontSize: RFont.size(context, 18, tablet: 20, desktop: 24)),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(color: Colors.black54, fontSize: RFont.size(context, 12, tablet: 13, desktop: 14)),
        ),
      ],
    ),
  );
}

// =========================================================
// 2. LEARN PAGE (UPDATED WITH 3 TRAINERS & TOGGLE)
// =========================================================
class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  String? _selectedKitItem;
  int? _selectedTrainerIndex;

  void _toggleKitItem(String item) {
    setState(() {
      _selectedKitItem = _selectedKitItem == item ? null : item;
    });
  }

  void _toggleTrainer(int index) {
    setState(() {
      _selectedTrainerIndex = _selectedTrainerIndex == index ? null : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (ScreenHelper.isDesktop(context)) {
          return _DesktopLearnView(
            selectedKitItem: _selectedKitItem,
            onToggleKitItem: _toggleKitItem,
            selectedTrainerIndex: _selectedTrainerIndex,
            onToggleTrainer: _toggleTrainer,
          );
        }
        if (ScreenHelper.isTablet(context)) {
          return _TabletLearnView(
            selectedKitItem: _selectedKitItem,
            onToggleKitItem: _toggleKitItem,
            selectedTrainerIndex: _selectedTrainerIndex,
            onToggleTrainer: _toggleTrainer,
          );
        }
        return _MobileLearnView(
          selectedKitItem: _selectedKitItem,
          onToggleKitItem: _toggleKitItem,
          selectedTrainerIndex: _selectedTrainerIndex,
          onToggleTrainer: _toggleTrainer,
        );
      },
    );
  }
}

// 🟢 Helper to build Trainer Cards
Widget _buildTrainerCard(BuildContext context, int index, bool isSelected, VoidCallback onTap) {
  final t = dummyTrainers[index];
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: isSelected ? const Color(0xFF3B66F5).withOpacity(0.05) : Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: isSelected ? const Color(0xFF3B66F5) : Colors.grey.shade200,
        width: isSelected ? 2 : 1,
      ),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF3B66F5).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: Color(0xFF3B66F5), size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t["name"]!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    t["role"]!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: isSelected ? const Color(0xFF3B66F5).withOpacity(0.1) : const Color(0xFF3B66F5),
              foregroundColor: isSelected ? const Color(0xFF3B66F5) : Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              isSelected ? "Hide Profile" : "View Profile",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ),
        ),
      ],
    ),
  );
}

// 🟢 Helper to build Trainer Detail Card on Toggle
Widget _buildTrainerDetails(BuildContext context, int index) {
  final t = dummyTrainers[index];
  return Container(
    margin: const EdgeInsets.only(top: 20),
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF3B66F5).withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B66F5).withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ]
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF3B66F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.school, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                "Profile Details - ${t["name"]}",
                style: GoogleFonts.poppins(
                  fontSize: RFont.size(context, 16, tablet: 18, desktop: 18),
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 16),
        Text(
          t["bio"]!,
          style: GoogleFonts.poppins(
            fontSize: RFont.size(context, 13, tablet: 14, desktop: 14),
            color: Colors.grey.shade700,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildInfoChip(Icons.work_outline, t["exp"]!),
            _buildInfoChip(Icons.star, "4.9 Rating"),
          ],
        )
      ],
    ),
  );
}

Widget _buildInfoChip(IconData icon, String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: const Color(0xFFF8F9FA),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade700),
        const SizedBox(width: 6),
        Text(text, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey.shade700)),
      ],
    ),
  );
}

// Helper Widget to show Data based on selected Kit Item
Widget _buildKitDetailsCard(BuildContext context, String selectedItem) {
  List<Map<String, String>> data = [];
  Color themeColor = const Color(0xFF3B66F5);

  if (selectedItem == "Important Topics") {
    themeColor = const Color(0xFF3B66F5);
    data = [
      {"title": "Mental Ability", "desc": "Analogy, Odd One Out, Figure Series"},
      {"title": "Arithmetic", "desc": "Number System, HCF & LCM, Profit & Loss"},
      {"title": "Language", "desc": "Reading Comprehension, Grammar, Vocabulary"},
    ];
  } else if (selectedItem == "Handwritten Notes") {
    themeColor = const Color(0xFFFF9800);
    data = [
      {"title": "MAT Notes PDF", "desc": "Complete handwritten notes (12 Pages)"},
      {"title": "Math Notes PDF", "desc": "Complete handwritten notes (24 Pages)"},
      {"title": "Language Notes PDF", "desc": "Complete handwritten notes (15 Pages)"},
    ];
  } else if (selectedItem == "Practice Sets") {
    themeColor = const Color(0xFF4CAF50);
    data = [
      {"title": "Mock Test 1", "desc": "50 Questions - 1 Hour"},
      {"title": "Mock Test 2", "desc": "50 Questions - 1 Hour"},
      {"title": "Daily Practice Set", "desc": "20 Questions - 30 Mins"},
    ];
  } else if (selectedItem == "Previous Year Papers") {
    themeColor = const Color(0xFFE91E63);
    data = [
      {"title": "JNVST 2023 Paper", "desc": "PDF Download (Available)"},
      {"title": "JNVST 2022 Paper", "desc": "PDF Download (Available)"},
      {"title": "JNVST 2021 Paper", "desc": "PDF Download (Available)"},
    ];
  }

  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 20),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: themeColor.withOpacity(0.3), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: themeColor.withOpacity(0.08),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Available $selectedItem:",
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: RFont.size(context, 16, tablet: 18, desktop: 18),
          ),
        ),
        const SizedBox(height: 12),
        const Divider(),
        const SizedBox(height: 8),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: themeColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, size: 14, color: themeColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index]['title']!,
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: RFont.size(context, 14, tablet: 15, desktop: 15),
                        ),
                      ),
                      Text(
                        data[index]['desc']!,
                        style: GoogleFonts.poppins(
                          color: Colors.grey.shade600,
                          fontSize: RFont.size(context, 12, tablet: 13, desktop: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    ),
  );
}

/// ================= DESKTOP VIEW =================
class _DesktopLearnView extends StatelessWidget {
  final String? selectedKitItem;
  final Function(String) onToggleKitItem;
  final int? selectedTrainerIndex;
  final Function(int) onToggleTrainer;

  const _DesktopLearnView({
    required this.selectedKitItem,
    required this.onToggleKitItem,
    required this.selectedTrainerIndex,
    required this.onToggleTrainer,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "NovaStudy – Jawahar Navodaya Vidyalaya Selection Test 2027 (Class 6)",
                    style: TextStyle(
                      fontSize: RFont.size(context, 28, desktop: 36),
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(color: const Color(0xFF3B66F5), borderRadius: BorderRadius.circular(8)),
                  child: const Text("Live", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // 🟢 TOP SELECTED TRAINERS SECTION (3 Cards)
          Text(
            "Meet Our Top Trainers",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: List.generate(dummyTrainers.length, (index) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: index < dummyTrainers.length - 1 ? 16.0 : 0),
                  child: _buildTrainerCard(context, index, selectedTrainerIndex == index, () => onToggleTrainer(index)),
                ),
              );
            }),
          ),

          // Toggle Trainer Details
          AnimatedCrossFade(
            firstChild: const SizedBox(height: 0, width: double.infinity),
            secondChild: selectedTrainerIndex != null
                ? _buildTrainerDetails(context, selectedTrainerIndex!)
                : const SizedBox.shrink(),
            crossFadeState: selectedTrainerIndex != null ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 400),
            sizeCurve: Curves.easeInOut,
          ),

          const SizedBox(height: 30),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Course Rating", style: TextStyle(fontSize: RFont.size(context, 18), fontWeight: FontWeight.bold, color: AppColors.textDark)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Color(0xFFFFB800), size: 32),
                          const SizedBox(width: 12),
                          Text("4.5", style: TextStyle(fontSize: RFont.size(context, 32), fontWeight: FontWeight.bold, color: AppColors.textDark)),
                          const SizedBox(width: 8),
                          Text("(1272)", style: TextStyle(fontSize: RFont.size(context, 16), color: Colors.grey.shade600)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: List.generate(5, (index) {
                          return const Icon(Icons.star, color: Color(0xFFFFB800), size: 20);
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B66F5),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: const Color(0xFF3B66F5).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Attend a Free Demo", style: TextStyle(fontSize: RFont.size(context, 20), fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 4),
                      Text("Prepare for JNVST 2027 with expert mentors", style: TextStyle(fontSize: RFont.size(context, 14), color: Colors.white.withOpacity(0.9))),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(child: _buildTextField(hint: "Full Name", icon: Icons.person)),
                          const SizedBox(width: 12),
                          Expanded(child: _buildTextField(hint: "Mobile Number", icon: Icons.phone)),
                          const SizedBox(width: 12),
                          Expanded(child: _buildTextField(hint: "Email Address", icon: Icons.email)),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                            child: const Text("Get Free Demo", style: TextStyle(color: Color(0xFF3B66F5), fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
                            child: const Text("Few seats left! Hurry up!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),

          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("JNVST 2027 (Class 6) Preparation Kit:", style: TextStyle(fontSize: RFont.size(context, 22), fontWeight: FontWeight.bold, color: AppColors.textDark)),
                const SizedBox(height: 10),
                Text("Aapko JNVST 2027 (Class 6) ke liye most important topics milenge, sath me well-maintained handwritten notes, practice sets, aur previous year question papers bhi denge jise bacche download karke practice kar sakte hain.", style: TextStyle(fontSize: RFont.size(context, 15), color: Colors.grey.shade700, height: 1.5)),
                const SizedBox(height: 24),
                Row(
                  children: [
                    _buildKeyTakeaway(context, icon: Icons.lightbulb, title: "Important Topics", color: const Color(0xFF3B66F5), isSelected: selectedKitItem == "Important Topics", onTap: () => onToggleKitItem("Important Topics")),
                    _buildKeyTakeaway(context, icon: Icons.edit_note, title: "Handwritten Notes", color: const Color(0xFFFF9800), isSelected: selectedKitItem == "Handwritten Notes", onTap: () => onToggleKitItem("Handwritten Notes")),
                    _buildKeyTakeaway(context, icon: Icons.assignment, title: "Practice Sets", color: const Color(0xFF4CAF50), isSelected: selectedKitItem == "Practice Sets", onTap: () => onToggleKitItem("Practice Sets")),
                    _buildKeyTakeaway(context, icon: Icons.history_edu, title: "Previous Year Papers", color: const Color(0xFFE91E63), isSelected: selectedKitItem == "Previous Year Papers", onTap: () => onToggleKitItem("Previous Year Papers")),
                  ],
                ),
                AnimatedCrossFade(
                  firstChild: const SizedBox(height: 0, width: double.infinity),
                  secondChild: selectedKitItem != null ? _buildKitDetailsCard(context, selectedKitItem!) : const SizedBox.shrink(),
                  crossFadeState: selectedKitItem != null ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 400),
                  sizeCurve: Curves.easeInOut,
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(color: const Color(0xFF3B66F5), borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Users Enrolled for JNVST 2027 Course Till Date", style: TextStyle(fontSize: RFont.size(context, 18), fontWeight: FontWeight.bold, color: Colors.white)),
                Text("109,963", style: TextStyle(fontSize: RFont.size(context, 32), fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required String hint, required IconData icon}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade400),
          prefixIcon: Icon(icon, size: 18, color: Colors.grey.shade400),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildKeyTakeaway(BuildContext context, {required IconData icon, required String title, required Color color, required bool isSelected, required VoidCallback onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.08) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: isSelected ? Border.all(color: color, width: 1.5) : null,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textDark)),
              ),
              if(isSelected) Icon(Icons.check_circle, color: color, size: 18)
            ],
          ),
        ),
      ),
    );
  }
}

/// ================= TABLET VIEW =================
class _TabletLearnView extends StatelessWidget {
  final String? selectedKitItem;
  final Function(String) onToggleKitItem;
  final int? selectedTrainerIndex;
  final Function(int) onToggleTrainer;

  const _TabletLearnView({
    required this.selectedKitItem,
    required this.onToggleKitItem,
    required this.selectedTrainerIndex,
    required this.onToggleTrainer,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "NovaStudy – JNVST 2027 (Class 6)",
                    style: TextStyle(fontSize: RFont.size(context, 24, tablet: 28), fontWeight: FontWeight.bold, color: AppColors.textDark),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(color: const Color(0xFF3B66F5), borderRadius: BorderRadius.circular(6)),
                  child: const Text("Live", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 🟢 TOP SELECTED TRAINERS SECTION (3 Cards Row)
          Text("Meet Our Top Trainers", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(height: 12),
          Row(
            children: List.generate(dummyTrainers.length, (index) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: index < dummyTrainers.length - 1 ? 12.0 : 0),
                  child: _buildTrainerCard(context, index, selectedTrainerIndex == index, () => onToggleTrainer(index)),
                ),
              );
            }),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(height: 0, width: double.infinity),
            secondChild: selectedTrainerIndex != null ? _buildTrainerDetails(context, selectedTrainerIndex!) : const SizedBox.shrink(),
            crossFadeState: selectedTrainerIndex != null ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 400),
            sizeCurve: Curves.easeInOut,
          ),
          const SizedBox(height: 24),

          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Course Rating", style: TextStyle(fontSize: RFont.size(context, 16), fontWeight: FontWeight.bold, color: AppColors.textDark)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Color(0xFFFFB800), size: 28),
                        const SizedBox(width: 10),
                        Text("4.5", style: TextStyle(fontSize: RFont.size(context, 28), fontWeight: FontWeight.bold, color: AppColors.textDark)),
                        const SizedBox(width: 6),
                        Text("(1272)", style: TextStyle(fontSize: RFont.size(context, 14), color: Colors.grey.shade600)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: List.generate(5, (index) {
                        return const Icon(Icons.star, color: Color(0xFFFFB800), size: 18);
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B66F5),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: const Color(0xFF3B66F5).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Attend a Free Demo", style: TextStyle(fontSize: RFont.size(context, 18), fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 2),
                    Text("Prepare for JNVST 2027 with expert mentors", style: TextStyle(fontSize: RFont.size(context, 13), color: Colors.white.withOpacity(0.9))),
                    const SizedBox(height: 14),
                    Column(
                      children: [
                        _buildTextField(hint: "Full Name", icon: Icons.person),
                        const SizedBox(height: 10),
                        _buildTextField(hint: "Mobile Number", icon: Icons.phone),
                        const SizedBox(height: 10),
                        _buildTextField(hint: "Email Address", icon: Icons.email),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                          child: const Text("Get Free Demo", textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF3B66F5), fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
                      child: const Text("Few seats left! Hurry up!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("JNVST 2027 (Class 6) Preparation Kit:", style: TextStyle(fontSize: RFont.size(context, 20), fontWeight: FontWeight.bold, color: AppColors.textDark)),
                const SizedBox(height: 10),
                Text("Aapko JNVST 2027 ke liye most important topics, handwritten notes, practice sets, aur previous year question papers milenge jise download karke practice kar sakte hain.", style: TextStyle(fontSize: RFont.size(context, 14), color: Colors.grey.shade700, height: 1.5)),
                const SizedBox(height: 20),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 3,
                  children: [
                    _buildKeyTakeaway(context, icon: Icons.lightbulb, title: "Important Topics", color: const Color(0xFF3B66F5), isSelected: selectedKitItem == "Important Topics", onTap: () => onToggleKitItem("Important Topics")),
                    _buildKeyTakeaway(context, icon: Icons.edit_note, title: "Handwritten Notes", color: const Color(0xFFFF9800), isSelected: selectedKitItem == "Handwritten Notes", onTap: () => onToggleKitItem("Handwritten Notes")),
                    _buildKeyTakeaway(context, icon: Icons.assignment, title: "Practice Sets", color: const Color(0xFF4CAF50), isSelected: selectedKitItem == "Practice Sets", onTap: () => onToggleKitItem("Practice Sets")),
                    _buildKeyTakeaway(context, icon: Icons.history_edu, title: "Previous Year Papers", color: const Color(0xFFE91E63), isSelected: selectedKitItem == "Previous Year Papers", onTap: () => onToggleKitItem("Previous Year Papers")),
                  ],
                ),
                AnimatedCrossFade(
                  firstChild: const SizedBox(height: 0, width: double.infinity),
                  secondChild: selectedKitItem != null ? _buildKitDetailsCard(context, selectedKitItem!) : const SizedBox.shrink(),
                  crossFadeState: selectedKitItem != null ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 400),
                  sizeCurve: Curves.easeInOut,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: const Color(0xFF3B66F5), borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Users Enrolled for JNVST 2027 Course Till Date", style: TextStyle(fontSize: RFont.size(context, 16), fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 8),
                Text("109,963", style: TextStyle(fontSize: RFont.size(context, 28), fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required String hint, required IconData icon}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400),
          prefixIcon: Icon(icon, size: 18, color: Colors.grey.shade400),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
      ),
    );
  }

  Widget _buildKeyTakeaway(BuildContext context, {required IconData icon, required String title, required Color color, required bool isSelected, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isSelected ? Border.all(color: color, width: 1.5) : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark))),
            if(isSelected) Icon(Icons.check_circle, color: color, size: 16)
          ],
        ),
      ),
    );
  }
}

/// ================= MOBILE VIEW =================
class _MobileLearnView extends StatelessWidget {
  final String? selectedKitItem;
  final Function(String) onToggleKitItem;
  final int? selectedTrainerIndex;
  final Function(int) onToggleTrainer;

  const _MobileLearnView({
    required this.selectedKitItem,
    required this.onToggleKitItem,
    required this.selectedTrainerIndex,
    required this.onToggleTrainer,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text("NovaStudy – JNVST 2027 (Class 6)", style: TextStyle(fontSize: RFont.size(context, 20), fontWeight: FontWeight.bold, color: AppColors.textDark))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFF3B66F5), borderRadius: BorderRadius.circular(4)),
                  child: const Text("Live", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 🟢 TOP SELECTED TRAINERS SECTION (3 Cards Column)
          Text("Meet Our Top Trainers", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(height: 12),
          Column(
            children: List.generate(dummyTrainers.length, (index) {
              return Padding(
                padding: EdgeInsets.only(bottom: index < dummyTrainers.length - 1 ? 12.0 : 0),
                child: _buildTrainerCard(context, index, selectedTrainerIndex == index, () => onToggleTrainer(index)),
              );
            }),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(height: 0, width: double.infinity),
            secondChild: selectedTrainerIndex != null ? _buildTrainerDetails(context, selectedTrainerIndex!) : const SizedBox.shrink(),
            crossFadeState: selectedTrainerIndex != null ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 400),
            sizeCurve: Curves.easeInOut,
          ),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Course Rating", style: TextStyle(fontSize: RFont.size(context, 15), fontWeight: FontWeight.bold, color: AppColors.textDark)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFFFFB800), size: 24),
                    const SizedBox(width: 8),
                    Text("4.5", style: TextStyle(fontSize: RFont.size(context, 24), fontWeight: FontWeight.bold, color: AppColors.textDark)),
                    const SizedBox(width: 4),
                    Text("(1272)", style: TextStyle(fontSize: RFont.size(context, 12), color: Colors.grey.shade600)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(5, (index) {
                    return const Icon(Icons.star, color: Color(0xFFFFB800), size: 16);
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF3B66F5),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: const Color(0xFF3B66F5).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Attend a Free Demo", style: TextStyle(fontSize: RFont.size(context, 18), fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 2),
                Text("Prepare for JNVST 2027 with expert mentors", style: TextStyle(fontSize: RFont.size(context, 13), color: Colors.white.withOpacity(0.9))),
                const SizedBox(height: 14),
                _buildTextField(hint: "Full Name", icon: Icons.person),
                const SizedBox(height: 10),
                _buildTextField(hint: "Mobile Number", icon: Icons.phone),
                const SizedBox(height: 10),
                _buildTextField(hint: "Email Address", icon: Icons.email),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  child: const Text("Get Free Demo", textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF3B66F5), fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
                  child: const Text("Few seats left! Hurry up!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("JNVST 2027 (Class 6) Preparation Kit:", style: TextStyle(fontSize: RFont.size(context, 18), fontWeight: FontWeight.bold, color: AppColors.textDark)),
                const SizedBox(height: 10),
                Text("Most important topics, well-maintained handwritten notes, practice sets, aur previous year question papers download karke practice karein.", style: TextStyle(fontSize: RFont.size(context, 13), color: Colors.grey.shade700, height: 1.4)),
                const SizedBox(height: 16),
                Column(
                  children: [
                    _buildKeyTakeaway(context, icon: Icons.lightbulb, title: "Important Topics", color: const Color(0xFF3B66F5), isSelected: selectedKitItem == "Important Topics", onTap: () => onToggleKitItem("Important Topics")),
                    const SizedBox(height: 10),
                    _buildKeyTakeaway(context, icon: Icons.edit_note, title: "Handwritten Notes", color: const Color(0xFFFF9800), isSelected: selectedKitItem == "Handwritten Notes", onTap: () => onToggleKitItem("Handwritten Notes")),
                    const SizedBox(height: 10),
                    _buildKeyTakeaway(context, icon: Icons.assignment, title: "Practice Sets", color: const Color(0xFF4CAF50), isSelected: selectedKitItem == "Practice Sets", onTap: () => onToggleKitItem("Practice Sets")),
                    const SizedBox(height: 10),
                    _buildKeyTakeaway(context, icon: Icons.history_edu, title: "Previous Year Papers", color: const Color(0xFFE91E63), isSelected: selectedKitItem == "Previous Year Papers", onTap: () => onToggleKitItem("Previous Year Papers")),
                  ],
                ),
                AnimatedCrossFade(
                  firstChild: const SizedBox(height: 0, width: double.infinity),
                  secondChild: selectedKitItem != null ? _buildKitDetailsCard(context, selectedKitItem!) : const SizedBox.shrink(),
                  crossFadeState: selectedKitItem != null ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 400),
                  sizeCurve: Curves.easeInOut,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFF3B66F5), borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Users Enrolled for JNVST 2027 Course Till Date", style: TextStyle(fontSize: RFont.size(context, 14), fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 6),
                Text("109,963", style: TextStyle(fontSize: RFont.size(context, 24), fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildTextField({required String hint, required IconData icon}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400),
          prefixIcon: Icon(icon, size: 18, color: Colors.grey.shade400),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
      ),
    );
  }

  Widget _buildKeyTakeaway(BuildContext context, {required IconData icon, required String title, required Color color, required bool isSelected, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isSelected ? Border.all(color: color, width: 1.5) : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(title, style: TextStyle(fontSize: RFont.size(context, 14), fontWeight: FontWeight.w600, color: AppColors.textDark))),
            if(isSelected) Icon(Icons.check_circle, color: color, size: 16)
          ],
        ),
      ),
    );
  }
}

// =========================================================
// 3. DEMO REGISTRATION FORM
// =========================================================
class _DemoRegistrationForm extends StatefulWidget {
  const _DemoRegistrationForm({Key? key}) : super(key: key);

  @override
  State<_DemoRegistrationForm> createState() => _DemoRegistrationFormState();
}

class _DemoRegistrationFormState extends State<_DemoRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();

  String? _selectedClass;
  final List<String> _classes = ['Class 3', 'Class 4', 'Class 5', 'Class 6', 'Class 7', 'Class 8'];

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final Uri url = Uri.parse('https://www.youtube.com/@navostudy');
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        debugPrint('Could not launch $url');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF3B66F5).withOpacity(0.3), width: 2),
        boxShadow: [BoxShadow(color: const Color(0xFF3B66F5).withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: const Color(0xFF3B66F5).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.person_add_alt_1, color: Color(0xFF3B66F5), size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    "Register for Free Demo",
                    style: GoogleFonts.poppins(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: RFont.size(context, 18, tablet: 20, desktop: 22)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),

            ScreenHelper.isDesktop(context) || ScreenHelper.isTablet(context)
                ? Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildInputField(
                        controller: _nameController,
                        label: "Full Name",
                        icon: Icons.person_outline,
                        validator: (value) => value!.isEmpty ? "Please enter your name" : null,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildInputField(
                        controller: _mobileController,
                        label: "Mobile Number",
                        icon: Icons.phone_outlined,
                        isPhone: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) return "Please enter mobile number";
                          if (value.length < 10) return "Enter a valid 10-digit number";
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildClassDropdown()),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: SizedBox(
                          height: 55,
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3B66F5),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text("Submit & Join", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
                : Column(
              children: [
                _buildInputField(
                  controller: _nameController,
                  label: "Full Name",
                  icon: Icons.person_outline,
                  validator: (value) => value!.isEmpty ? "Please enter your name" : null,
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  controller: _mobileController,
                  label: "Mobile Number",
                  icon: Icons.phone_outlined,
                  isPhone: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Please enter mobile number";
                    if (value.length < 10) return "Enter a valid 10-digit number";
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildClassDropdown(),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B66F5),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text("Submit & Join", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({required TextEditingController controller, required String label, required IconData icon, bool isPhone = false, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF3B66F5)),
        labelStyle: GoogleFonts.poppins(color: Colors.black54, fontSize: 14),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF3B66F5), width: 2)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.redAccent, width: 1)),
      ),
    );
  }

  Widget _buildClassDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedClass,
      decoration: InputDecoration(
        labelText: "Select Class",
        prefixIcon: const Icon(Icons.school_outlined, color: Color(0xFF3B66F5)),
        labelStyle: GoogleFonts.poppins(color: Colors.black54, fontSize: 14),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF3B66F5), width: 2)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.redAccent, width: 1)),
      ),
      items: _classes.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: GoogleFonts.poppins(color: Colors.black87, fontSize: 14)),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedClass = newValue;
        });
      },
      validator: (value) => value == null ? "Please select your class" : null,
    );
  }
}