import 'package:navostudy/core/widget/responsive_font.dart';
import 'package:navostudy/core/widget/screen_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart'; // ✅ Added for YouTube link

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
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: const _DemoRegistrationForm(),
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

// =========================================================
// 📝 DEMO REGISTRATION FORM
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

  // ✅ State for Class Dropdown (Class 3 - 8)
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
                    "Register for Free Practice",
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