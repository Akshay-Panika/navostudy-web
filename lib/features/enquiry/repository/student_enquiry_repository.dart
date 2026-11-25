import 'package:dio/dio.dart';
import 'package:navostudy/core/network/api_urls.dart';
import '../../../core/network/api_client.dart';
import '../model/student_enquiry_model.dart';

class StudentEnquiryRepository {
  Future<StudentEnquiryResponse> createEnquiry(
      StudentEnquiryRequest request) async {
    try {
      final response = await ApiClient.dio.post(
        ApiUrls.createStudentEnquiry,
        data: request.toJson(),

      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return StudentEnquiryResponse.fromJson(
          response.data is Map<String, dynamic>
              ? response.data
              : Map<String, dynamic>.from(response.data),
        );
      }

      throw Exception(
          "Unexpected status code: ${response.statusCode}");
    } on DioException catch (e) {
      final msg = e.response?.data is Map
          ? (e.response!.data['message'] ?? e.response!.data.toString())
          : (e.message ?? "Network error");
      throw Exception(msg);
    }
  }
}