import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/widget/responsive_font.dart';
import '../../../core/widget/screen_helper.dart';
import '../controller/student_enquiry_controller.dart';

class EnquiryFormCard extends StatefulWidget {
  const EnquiryFormCard({super.key});

  @override
  State<EnquiryFormCard> createState() => _EnquiryFormCardState();
}

class _EnquiryFormCardState extends State<EnquiryFormCard> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _messageController = TextEditingController(); // 🔹 Naya Message Controller

  String? _selectedClass;

  final List<String> _classes = const [
    'Class 3th',
    'Class 4th',
    'Class 5th',
    'Class 6th',
    'Class 7th',
    'Class 8th',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _messageController.dispose(); // 🔹 Dispose karna mat bhoolna
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final controller = Get.find<StudentEnquiryController>();

    // 🔹 Agar message khali hai toh default message bhejenge
    final msgText = _messageController.text.trim().isEmpty
        ? "Admission enquiry ke liye call kiya"
        : _messageController.text.trim();

    final ok = await controller.submitEnquiry(
      name: _nameController.text.trim(),
      phone: _mobileController.text.trim(),
      studentClass: _selectedClass ?? '',
      message: msgText,
    );

    if (ok) {
      FocusScope.of(context).unfocus();

      _nameController.clear();
      _mobileController.clear();
      _messageController.clear(); // 🔹 Message clear karo

      setState(() {
        _selectedClass = null;
      });
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
        border: Border.all(
          color: const Color(0xFF3B66F5).withOpacity(0.3),
          width: 2,
        ),
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
                  child: const Icon(
                    Icons.person_add_alt_1,
                    color: Color(0xFF3B66F5),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    "Register for Free Practice",
                    style: GoogleFonts.poppins(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize:
                      RFont.size(context, 18, tablet: 20, desktop: 22),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),

            if (ScreenHelper.isDesktop(context) ||
                ScreenHelper.isTablet(context))
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildInputField(
                          controller: _nameController,
                          label: "Full Name",
                          icon: Icons.person_outline,
                          validator: (value) => (value == null ||
                              value.trim().isEmpty)
                              ? "Please enter your name"
                              : null,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildInputField(
                          controller: _mobileController,
                          label: "Mobile Number",
                          icon: Icons.phone_outlined,
                          isPhone: true,
                          validator: _phoneValidator,
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
                        // Message field (Optional)
                        child: _buildInputField(
                          controller: _messageController,
                          label: "Message (Optional)",
                          icon: Icons.chat_bubble_outline,
                          // No validator = Optional field
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Full width Submit Button for Desktop/Tablet
                  _buildSubmitButton(
                    height: 55,
                    width: double.infinity,
                  ),
                ],
              )
            else
              Column(
                children: [
                  _buildInputField(
                    controller: _nameController,
                    label: "Full Name",
                    icon: Icons.person_outline,
                    validator: (value) =>
                    (value == null || value.trim().isEmpty)
                        ? "Please enter your name"
                        : null,
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    controller: _mobileController,
                    label: "Mobile Number",
                    icon: Icons.phone_outlined,
                    isPhone: true,
                    validator: _phoneValidator,
                  ),
                  const SizedBox(height: 16),
                  _buildClassDropdown(),
                  const SizedBox(height: 16),
                  _buildInputField(
                    controller: _messageController,
                    label: "Message (Optional)",
                    icon: Icons.chat_bubble_outline,
                    // No validator = Optional field
                  ),
                  const SizedBox(height: 20),
                  _buildSubmitButton(
                    height: 55,
                    width: double.infinity,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // ---------------- Submit Button (reactive) ----------------

  Widget _buildSubmitButton({required double height, double? width}) {
    return Obx(() {
      final isLoading =
          Get.find<StudentEnquiryController>().isLoading.value;

      return SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: isLoading ? null : _submitForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3B66F5),
            foregroundColor: Colors.white,
            disabledBackgroundColor:
            const Color(0xFF3B66F5).withOpacity(0.6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: isLoading
              ? const SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.4,
              color: Colors.white,
            ),
          )
              : Text(
            "Submit & Join",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      );
    });
  }

  String? _phoneValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter mobile number";
    }
    if (value.trim().length < 10) {
      return "Enter a valid 10-digit number";
    }
    return null;
  }

  // ---------------- Input Field ----------------

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
        labelStyle: GoogleFonts.poppins(
          color: Colors.black54,
          fontSize: 14,
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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

  // ---------------- Class Dropdown ----------------

  Widget _buildClassDropdown() {
    return DropdownButtonFormField<String>(
      key: ValueKey(_selectedClass),
      value: _selectedClass,
      decoration: InputDecoration(
        labelText: "Select Class",
        prefixIcon:
        const Icon(Icons.school_outlined, color: Color(0xFF3B66F5)),
        labelStyle: GoogleFonts.poppins(
          color: Colors.black54,
          fontSize: 14,
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
            style: GoogleFonts.poppins(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
        );
      }).toList(),
      onChanged: (newValue) => setState(() => _selectedClass = newValue),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) =>
      value == null ? "Please select your class" : null,
    );
  }
}