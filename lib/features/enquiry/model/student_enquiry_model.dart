// ---------- Request ----------
class StudentEnquiryRequest {
  final String name;
  final String phone;
  final String studentClass;
  final String message;

  StudentEnquiryRequest({
    required this.name,
    required this.phone,
    required this.studentClass,
    required this.message,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "student_class": studentClass,
    "message": message,
  };
}

// ---------- Response ----------
class StudentEnquiryResponse {
  final bool success;
  final String message;
  final StudentEnquiryData? data;

  StudentEnquiryResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory StudentEnquiryResponse.fromJson(Map<String, dynamic> json) {
    return StudentEnquiryResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? StudentEnquiryData.fromJson(json['data'])
          : null,
    );
  }
}

class StudentEnquiryData {
  final int id;
  final String name;
  final String phone;
  final String studentClass;
  final String message;

  StudentEnquiryData({
    required this.id,
    required this.name,
    required this.phone,
    required this.studentClass,
    required this.message,
  });

  factory StudentEnquiryData.fromJson(Map<String, dynamic> json) {
    return StudentEnquiryData(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      studentClass: json['student_class'] ?? '',
      message: json['message'] ?? '',
    );
  }
}