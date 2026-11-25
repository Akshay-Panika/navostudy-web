import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navostudy/core/utils/app_color.dart';
import '../../../core/widget/responsive_font.dart';
import '../../../core/widget/screen_helper.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktopOrTablet =
        ScreenHelper.isTablet(context) || ScreenHelper.isDesktop(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FF),
      appBar: AppBar(
        title: Text(
          "Student Dashboard",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: RFont.size(context, 14, tablet: 16, desktop: 18),
          ),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: const Color(0xFF1A1D2E),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.close,color: Colors.white,)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktopOrTablet ? 40 : 16,
          vertical: 10,
        ),
        child: isDesktopOrTablet
            ? _desktopLayout(context)
            : _mobileLayout(context),
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  LAYOUTS
  // ─────────────────────────────────────────────

  Widget _mobileLayout(BuildContext context) {
    return Column(
      children: [
        _profileHeader(context),
        const SizedBox(height: 20),
        _statsDashboard(context),
        const SizedBox(height: 20),
        _rankCard(context),
        const SizedBox(height: 20),
        _registrationCard(context),
        const SizedBox(height: 20),
        _subjectsCard(context),
        const SizedBox(height: 20),
        _documentsCard(context),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _desktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column
        SizedBox(
          width: 340,
          child: Column(
            children: [
              _profileHeader(context),
              const SizedBox(height: 20),
              _rankCard(context),
              const SizedBox(height: 20),
              _documentsCard(context),
            ],
          ),
        ),

        const SizedBox(width: 30),

        // Right Column
        Expanded(
          child: Column(
            children: [
              _statsDashboard(context),
              const SizedBox(height: 20),
              _registrationCard(context),
              const SizedBox(height: 20),
              _subjectsCard(context),
            ],
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────
  //  1. PREMIUM PROFILE HEADER (Gradient + Overlapping Avatar)
  // ─────────────────────────────────────────────
  Widget _profileHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B66F5).withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Gradient Banner
          Container(
            height: 110,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF3B66F5), Color(0xFF6B8DF8)],
              ),
            ),
          ),

          // Avatar overlapping the banner
          Transform.translate(
            offset: const Offset(0, -45),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFEEF1FF),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Color(0xFF3B66F5),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 4, bottom: 4),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B66F5),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
                ),
              ],
            ),
          ),

          // Name & Badge
          Transform.translate(
            offset: const Offset(0, -35),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Rahul Sharma",
                      style: GoogleFonts.poppins(
                        fontSize: RFont.size(context, 18, tablet: 20, desktop: 22),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A1D2E),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.verified, color: Color(0xFF3B66F5), size: 20),
                  ],
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF1FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Class 8 • Science",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF3B66F5),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Contact Info
          Transform.translate(
            offset: const Offset(0, -20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Divider(color: Color(0xFFF1F4F9)),
                  const SizedBox(height: 10),
                  _infoRow(Icons.email_outlined, "rahul.sharma@email.com"),
                  _infoRow(Icons.phone_outlined, "+91 98765 43210"),
                  _infoRow(Icons.location_on_outlined, "Sector 21, New Delhi"),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  2. UNIFIED STATS DASHBOARD
  // ─────────────────────────────────────────────
  Widget _statsDashboard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _statItem(
              context,
              "92%",
              "Attendance",
              Icons.event_available,
              const Color(0xFF22C55E),
            ),
          ),
          _verticalDivider(),
          Expanded(
            child: _statItem(
              context,
              "87%",
              "Avg Marks",
              Icons.bar_chart_rounded,
              const Color(0xFF3B66F5),
            ),
          ),
          _verticalDivider(),
          Expanded(
            child: _statItem(
              context,
              "#3",
              "Class Rank",
              Icons.emoji_events_rounded,
              const Color(0xFFF59E0B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statItem(BuildContext context, String value, String label, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(height: 12),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: RFont.size(context, 16, tablet: 18, desktop: 20),
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A1D2E),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(
      height: 50,
      width: 1,
      color: const Color(0xFFF1F4F9),
    );
  }

  // ─────────────────────────────────────────────
  //  3. RANK CARD
  // ─────────────────────────────────────────────
  Widget _rankCard(BuildContext context) {
    return _modernCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(Icons.leaderboard_outlined, "Performance Ranking", const Color(0xFFF59E0B)),
          const SizedBox(height: 20),
          _rankRow("Class Rank", "#3", "out of 42", const Color(0xFF3B66F5)),
          const SizedBox(height: 14),
          _rankRow("School Rank", "#12", "out of 380", const Color(0xFFF59E0B)),
          const SizedBox(height: 14),
          _rankRow("District Rank", "#45", "out of 2400", const Color(0xFF22C55E)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Overall Performance",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF64748B),
                ),
              ),
              Text(
                "87%",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF3B66F5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.87,
              minHeight: 12,
              backgroundColor: const Color(0xFFEEF1FF),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3B66F5)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rankRow(String label, String rank, String sub, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.military_tech, color: color, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1A1D2E),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              rank,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            Text(
              sub,
              style: GoogleFonts.poppins(
                fontSize: 10,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────
  //  4. REGISTRATION DATA CARD
  // ─────────────────────────────────────────────
  Widget _registrationCard(BuildContext context) {
    return _modernCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(Icons.assignment_ind_outlined, "Registration Details", const Color(0xFF3B66F5)),
          const SizedBox(height: 20),
          _detailGrid(context, [
            ["Roll Number", "DPS-2024-1087"],
            ["Registration ID", "REG-2024-XJ99"],
            ["Admission Date", "01 April 2024"],
            ["Board", "CBSE"],
            ["Stream", "Science (PCM)"],
            ["Medium", "English"],
            ["Father's Name", "Anil Sharma"],
            ["Mother's Name", "Sunita Sharma"],
          ]),
        ],
      ),
    );
  }

  Widget _detailGrid(BuildContext context, List<List<String>> items) {
    final isWide = ScreenHelper.isTablet(context) || ScreenHelper.isDesktop(context);
    final rows = <Widget>[];

    for (var i = 0; i < items.length; i += (isWide ? 2 : 1)) {
      final rowItems = items.sublist(i, (i + (isWide ? 2 : 1)).clamp(0, items.length));
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: rowItems.map((item) {
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item[0],
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item[1],
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A1D2E),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      );
    }
    return Column(children: rows);
  }

  // ─────────────────────────────────────────────
  //  5. SUBJECTS CARD
  // ─────────────────────────────────────────────
  Widget _subjectsCard(BuildContext context) {
    final subjects = [
      {"name": "Mathematics", "marks": 94, "max": 100},
      {"name": "Physics", "marks": 88, "max": 100},
      {"name": "Chemistry", "marks": 82, "max": 100},
      {"name": "English", "marks": 90, "max": 100},
      {"name": "Computer Science", "marks": 96, "max": 100},
    ];

    return _modernCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(Icons.auto_graph, "Subject Performance", const Color(0xFF22C55E)),
          const SizedBox(height: 20),
          ...subjects.map((s) {
            final pct = (s["marks"] as int) / (s["max"] as int);
            final color = pct >= 0.9
                ? const Color(0xFF22C55E)
                : pct >= 0.75
                ? const Color(0xFF3B66F5)
                : const Color(0xFFF59E0B);

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        s["name"] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1A1D2E),
                        ),
                      ),
                      Text(
                        "${s["marks"]} / ${s["max"]}",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: pct,
                      minHeight: 8,
                      backgroundColor: const Color(0xFFF1F4F9),
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  6. DOCUMENTS CARD
  // ─────────────────────────────────────────────
  Widget _documentsCard(BuildContext context) {
    return _modernCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(Icons.folder_open_outlined, "Documents", const Color(0xFF8B5CF6)),
          const SizedBox(height: 16),
          _docItem(Icons.badge_outlined, "Aadhar Card", "Verified", const Color(0xFF22C55E)),
          _docItem(Icons.image_outlined, "Passport Photo", "Verified", const Color(0xFF22C55E)),
          _docItem(Icons.description_outlined, "Previous Marksheet", "Pending", const Color(0xFFF59E0B)),
        ],
      ),
    );
  }

  Widget _docItem(IconData icon, String title, String status, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F7FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF3B66F5), size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1A1D2E),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  HELPERS
  // ─────────────────────────────────────────────

  Widget _modernCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _sectionTitle(IconData icon, String title, Color iconColor) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A1D2E),
          ),
        ),
      ],
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF94A3B8)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF475569),
              ),
            ),
          ),
        ],
      ),
    );
  }
}