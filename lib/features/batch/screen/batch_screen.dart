import 'package:navostudy/core/widget/responsive_font.dart';
import 'package:navostudy/core/widget/screen_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

// 🔴 Changed to StatefulWidget to manage Syllabus and Demo Form states
class BatchScreen extends StatefulWidget {
  const BatchScreen({super.key});

  @override
  State<BatchScreen> createState() => _BatchScreenState();
}

class _BatchScreenState extends State<BatchScreen> {
  // State to toggle syllabus
  bool _showSyllabus = false;

  // State to toggle demo form
  bool _showDemoForm = false;

  void _toggleSyllabus() {
    setState(() {
      _showSyllabus = !_showSyllabus;
      if (_showSyllabus) _showDemoForm = false; // Close form if opening syllabus
    });
  }

  void _toggleDemoForm() {
    setState(() {
      _showDemoForm = !_showDemoForm;
      if (_showDemoForm) _showSyllabus = false; // Close syllabus if opening form
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (ScreenHelper.isDesktop(context) ||
              ScreenHelper.isTablet(context)) {
            return _DesktopView(
              showSyllabus: _showSyllabus,
              onToggleSyllabus: _toggleSyllabus,
              showDemoForm: _showDemoForm,
              onToggleDemoForm: _toggleDemoForm,
            );
          }
          return _MobileView(
            showSyllabus: _showSyllabus,
            onToggleSyllabus: _toggleSyllabus,
            showDemoForm: _showDemoForm,
            onToggleDemoForm: _toggleDemoForm,
          );
        },
      ),
    );
  }
}

/// ===============================
/// DESKTOP VIEW
/// ===============================
class _DesktopView extends StatelessWidget {
  final bool showSyllabus;
  final VoidCallback onToggleSyllabus;
  final bool showDemoForm;
  final VoidCallback onToggleDemoForm;

  const _DesktopView({
    required this.showSyllabus,
    required this.onToggleSyllabus,
    required this.showDemoForm,
    required this.onToggleDemoForm,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTablet = ScreenHelper.isTablet(context);

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 30 : 100,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTag(context),
                    const SizedBox(height: 25),
                    Text(
                      "Choose The Right\nBatch For You",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: RFont.size(
                          context,
                          34,
                          tablet: 42,
                          desktop: 58,
                        ),
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 600,
                      child: Text(
                        "Start with our free Navoday batch, attend 15 days of free "
                            "demo classes, and then pick a paid batch to continue your "
                            "preparation with expert mentors.",
                        style: GoogleFonts.poppins(
                          color: Colors.black54,
                          fontSize: RFont.size(
                            context,
                            14,
                            tablet: 15,
                            desktop: 17,
                          ),
                          height: 1.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // --- TOP RIGHT IMAGE ---
              Container(
                height: 350,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  'assets/image/shoolboy.jpg',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),

          /// 🔴 FREE NAVODAY BATCH
          _buildFreeBanner(
            context,
            isTablet: isTablet,
            showSyllabus: showSyllabus,
            onToggleSyllabus: onToggleSyllabus,
            showDemoForm: showDemoForm,
            onToggleDemoForm: onToggleDemoForm,
          ),

          /// 🟢 ANIMATED DEMO FORM CARD
          AnimatedCrossFade(
            firstChild: const SizedBox(height: 0, width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: _DemoRegistrationForm(), // Form Widget
            ),
            crossFadeState: showDemoForm
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 400),
            sizeCurve: Curves.easeInOut,
          ),

          /// 🟢 ANIMATED SYLLABUS CARD
          AnimatedCrossFade(
            firstChild: const SizedBox(height: 0, width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: _buildSyllabusCard(context),
            ),
            crossFadeState: showSyllabus
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 400),
            sizeCurve: Curves.easeInOut,
          ),

          const SizedBox(height: 60),

          /// STATS
          Row(
            children: [
              Expanded(child: _buildStatCard(context, "500+", "Batches")),
              const SizedBox(width: 20),
              Expanded(
                child: _buildStatCard(context, "50K+", "Students Enrolled"),
              ),
              const SizedBox(width: 20),
              Expanded(child: _buildStatCard(context, "4.9", "Average Rating")),
            ],
          ),
        ],
      ),
    );
  }
}

/// ===============================
/// MOBILE VIEW
/// ===============================
class _MobileView extends StatelessWidget {
  final bool showSyllabus;
  final VoidCallback onToggleSyllabus;
  final bool showDemoForm;
  final VoidCallback onToggleDemoForm;

  const _MobileView({
    required this.showSyllabus,
    required this.onToggleSyllabus,
    required this.showDemoForm,
    required this.onToggleDemoForm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTag(context),
          const SizedBox(height: 25),
          Text(
            "Choose The Right\nBatch For You",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: RFont.size(context, 32),
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            "Start with our free Navoday batch, get 15 days of free demo "
                "classes, then choose a paid batch to continue.",
            style: GoogleFonts.poppins(
              color: Colors.black54,
              fontSize: RFont.size(context, 14),
              height: 1.7,
            ),
          ),
          const SizedBox(height: 30),

          /// 🔴 FREE NAVODAY BATCH
          _buildFreeBanner(
            context,
            isTablet: true,
            showSyllabus: showSyllabus,
            onToggleSyllabus: onToggleSyllabus,
            showDemoForm: showDemoForm,
            onToggleDemoForm: onToggleDemoForm,
          ),

          /// 🟢 ANIMATED DEMO FORM CARD
          AnimatedCrossFade(
            firstChild: const SizedBox(height: 0, width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: _DemoRegistrationForm(), // Form Widget
            ),
            crossFadeState: showDemoForm
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 400),
            sizeCurve: Curves.easeInOut,
          ),

          /// 🟢 ANIMATED SYLLABUS CARD
          AnimatedCrossFade(
            firstChild: const SizedBox(height: 0, width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: _buildSyllabusCard(context),
            ),
            crossFadeState: showSyllabus
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 400),
            sizeCurve: Curves.easeInOut,
          ),

          const SizedBox(height: 35),

          /// STATS
          Row(
            children: [
              Expanded(child: _buildStatCard(context, "500+", "Batches")),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard(context, "50K+", "Students")),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard(context, "4.9", "Rating")),
            ],
          ),
        ],
      ),
    );
  }
}

/// ===============================
/// TAG
/// ===============================
Widget _buildTag(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
    decoration: BoxDecoration(
      color: const Color(0xFFF07E3F),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Text(
      "Our Batches",
      style: GoogleFonts.poppins(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: RFont.size(context, 12, tablet: 13, desktop: 14),
      ),
    ),
  );
}

/// ===============================
/// 🔴 FREE NAVODAY BANNER (TOP)
/// ===============================
Widget _buildFreeBanner(
    BuildContext context, {
      required bool isTablet,
      required bool showSyllabus,
      required VoidCallback onToggleSyllabus,
      required bool showDemoForm,
      required VoidCallback onToggleDemoForm,
    }) {
  final bool wide = !isTablet;

  final Widget leftContent = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      /// BADGES
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          _badge(
            context,
            text: "FREE",
            bg: Colors.white,
            fg: const Color(0xFF3B66F5),
            icon: Icons.local_offer,
          ),
          _badge(
            context,
            text: "15 Days Free Demo Classes",
            bg: Colors.white.withOpacity(0.18),
            fg: Colors.white,
            icon: Icons.card_giftcard,
          ),
        ],
      ),
      const SizedBox(height: 20),

      /// TITLE
      Text(
        "Navodaya Final\nRevision Series",
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          height: 1.2,
          fontSize: RFont.size(
            context,
            24,
            tablet: 30,
            desktop: 36,
          ),
        ),
      ),
      const SizedBox(height: 14),

      /// DESCRIPTION
      Text(
        "Complete Navoday Vidyalaya entrance preparation with live "
            "classes, expert mentors, daily practice, and full mock tests — "
            "completely free for the first 15 days.",
        style: GoogleFonts.poppins(
          color: Colors.white70,
          height: 1.6,
          fontSize: RFont.size(
            context,
            12,
            tablet: 13,
            desktop: 14,
          ),
        ),
      ),
      const SizedBox(height: 22),

      /// HIGHLIGHTS
      Wrap(
        spacing: 16,
        runSpacing: 10,
        children: const [
          _FreeHighlight(text: "Live Classes"),
          _FreeHighlight(text: "Daily Tests"),
          _FreeHighlight(text: "Mock Papers"),
          _FreeHighlight(text: "Doubt Support"),
        ],
      ),
      const SizedBox(height: 28),

      /// BUTTONS
      Wrap(
        spacing: 16,
        runSpacing: 12,
        children: [
          ElevatedButton.icon(
            // ✅ TOGGLE FORM INSTEAD OF YOUTUBE URL
            onPressed: onToggleDemoForm,
            icon: const Icon(Icons.play_circle_fill, size: 18),
            label: Text(
              "Start Free Demo",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: RFont.size(
                  context,
                  12,
                  tablet: 13,
                  desktop: 14,
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF3B66F5),
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 18,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          OutlinedButton(
            onPressed: onToggleSyllabus,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white54),
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 18,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "View Syllabus",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: RFont.size(
                      context,
                      12,
                      tablet: 13,
                      desktop: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                AnimatedRotation(
                  turns: showSyllabus ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );

  /// 🧑‍🏫 TEACHER IMAGE CARD
  final Widget rightVisual = _buildTeacherCard(context);

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(30),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF3B66F5),
          Color(0xFF284CD3),
        ],
      ),
      borderRadius: BorderRadius.circular(28),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF3B66F5).withOpacity(0.3),
          blurRadius: 30,
          offset: const Offset(0, 15),
        ),
      ],
    ),
    child: wide
        ? Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: leftContent),
        const SizedBox(width: 30),
        rightVisual,
      ],
    )
        : Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        rightVisual,
        const SizedBox(height: 25),
        leftContent,
      ],
    ),
  );
}

/// ===============================
/// 📝 DEMO REGISTRATION FORM (UPDATED WITH CLASS)
/// ===============================
class _DemoRegistrationForm extends StatefulWidget {
  const _DemoRegistrationForm({Key? key}) : super(key: key);

  @override
  State<_DemoRegistrationForm> createState() => _DemoRegistrationFormState();
}

class _DemoRegistrationFormState extends State<_DemoRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();

  // ✅ State for Class Dropdown (Updated to Class 3 - 8)
  String? _selectedClass;
  final List<String> _classes = [
    'Class 3',
    'Class 4',
    'Class 5',
    'Class 6',
    'Class 7',
    'Class 8',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // 1. Yahan aap backend me data save kar sakte hain
      // debugPrint("Name: ${_nameController.text}");
      // debugPrint("Mobile: ${_mobileController.text}");
      // debugPrint("Class: $_selectedClass");

      // 2. Uske baad YouTube open hoga
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
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B66F5).withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
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
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B66F5).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.person_add_alt_1, color: Color(0xFF3B66F5), size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    "Register for Free Demo",
                    style: GoogleFonts.poppins(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: RFont.size(context, 18, tablet: 20, desktop: 22),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),

            // Responsive Form Fields (Row for Desktop, Column for Mobile)
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
                            child: Text(
                              "Submit & Join",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
                            ),
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
                _buildClassDropdown(), // ✅ Class Field for Mobile
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
                    child: Text(
                      "Submit & Join",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Custom Input Field Builder
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPhone = false,
    String? Function(String?)? validator,
  }) {
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3B66F5), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
      ),
    );
  }

  // ✅ Custom Dropdown for Class
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3B66F5), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
      ),
      items: _classes.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: GoogleFonts.poppins(color: Colors.black87, fontSize: 14),
          ),
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

/// ===============================
/// 📜 SYLLABUS CARD
/// ===============================
Widget _buildSyllabusCard(BuildContext context) {
  return Container(
    width: double.infinity,
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
                color: const Color(0xFF3B66F5).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.menu_book, color: Color(0xFF3B66F5), size: 24),
            ),
            const SizedBox(width: 16),
            Text(
              "Navoday Batch Syllabus",
              style: GoogleFonts.poppins(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: RFont.size(context, 20, tablet: 22, desktop: 24),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Divider(),
        const SizedBox(height: 20),

        // Subjects layout (Responsive Row/Column)
        ScreenHelper.isDesktop(context) || ScreenHelper.isTablet(context)
            ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildSubjectList(context, "Mental Ability Test (MAT)", Icons.psychology, ["Odd One Out", "Figure Matching", "Analogy", "Pattern Completion", "Spatial Visualization"])),
            const SizedBox(width: 20),
            Expanded(child: _buildSubjectList(context, "Arithmetic Test", Icons.calculate, ["Number System", "HCF & LCM", "Profit & Loss", "Ratio & Proportion", "Time, Work & Distance"])),
            const SizedBox(width: 20),
            Expanded(child: _buildSubjectList(context, "Language Test", Icons.translate, ["Reading Comprehension", "Grammar & Vocabulary", "Idioms & Phrases", "Sentence Correction", "Fill in the Blanks"])),
          ],
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubjectList(context, "Mental Ability Test (MAT)", Icons.psychology, ["Odd One Out", "Figure Matching", "Analogy", "Pattern Completion", "Spatial Visualization"]),
            const SizedBox(height: 20),
            _buildSubjectList(context, "Arithmetic Test", Icons.calculate, ["Number System", "HCF & LCM", "Profit & Loss", "Ratio & Proportion", "Time, Work & Distance"]),
            const SizedBox(height: 20),
            _buildSubjectList(context, "Language Test", Icons.translate, ["Reading Comprehension", "Grammar & Vocabulary", "Idioms & Phrases", "Sentence Correction", "Fill in the Blanks"]),
          ],
        ),
      ],
    ),
  );
}

/// HELPER WIDGET FOR SUBJECT LIST
Widget _buildSubjectList(BuildContext context, String title, IconData icon, List<String> topics) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(icon, color: const Color(0xFFF07E3F), size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: RFont.size(context, 15, tablet: 16, desktop: 16),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      ...topics.map((topic) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Icon(Icons.check_circle_outline, size: 14, color: Colors.grey),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                topic,
                style: GoogleFonts.poppins(
                  color: Colors.black54,
                  fontSize: RFont.size(context, 13, tablet: 13, desktop: 14),
                ),
              ),
            ),
          ],
        ),
      )),
    ],
  );
}

/// ===============================
/// 🧑‍🏫 TEACHER CARD
/// ===============================
Widget _buildTeacherCard(BuildContext context) {
  return Container(
    width: 240,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.18),
          blurRadius: 24,
          offset: const Offset(0, 12),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// TEACHER IMAGE
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Image.asset(
            'assets/management/shiv.png',
            height: 190,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 190,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B66F5).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      size: 70,
                      color: Color(0xFF3B66F5),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Image Not Found",
                      style: TextStyle(color: Color(0xFF3B66F5), fontSize: 12),
                    )
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 14),

        /// NAME
        Text(
          "Shreyansh Gupta",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: RFont.size(context, 14, tablet: 15, desktop: 16),
          ),
        ),
        const SizedBox(height: 4),

        /// SUBJECT
        Text(
          "Navoday Specialist",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: Colors.black54,
            fontSize: RFont.size(context, 11, tablet: 12, desktop: 12),
          ),
        ),
        const SizedBox(height: 12),

        /// DEMO BADGE
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF3B66F5).withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.verified, color: Color(0xFF3B66F5), size: 14),
              const SizedBox(width: 4),
              Text(
                "15 Days Free Demo",
                style: GoogleFonts.poppins(
                  color: const Color(0xFF3B66F5),
                  fontWeight: FontWeight.w600,
                  fontSize: RFont.size(context, 10, tablet: 11, desktop: 11),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// FREE BANNER BADGE
Widget _badge(
    BuildContext context, {
      required String text,
      required Color bg,
      required Color fg,
      required IconData icon,
    }) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: fg, size: 14),
        const SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.poppins(
            color: fg,
            fontWeight: FontWeight.w600,
            fontSize: RFont.size(context, 11, tablet: 12, desktop: 12),
          ),
        ),
      ],
    ),
  );
}

/// FREE BANNER HIGHLIGHT CHIP
class _FreeHighlight extends StatelessWidget {
  final String text;
  const _FreeHighlight({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_circle, color: Colors.white, size: 16),
        const SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: RFont.size(context, 12, tablet: 13, desktop: 13),
          ),
        ),
      ],
    );
  }
}

/// ===============================
/// STAT CARD
/// ===============================
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
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: RFont.size(context, 18, tablet: 20, desktop: 24),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: Colors.black54,
            fontSize: RFont.size(context, 12, tablet: 13, desktop: 14),
          ),
        ),
      ],
    ),
  );
}