import 'package:get/get.dart';
import '../../../core/widget/flutter_toast.dart'; // adjust path to your FlutterToast class
import '../model/student_enquiry_model.dart';
import '../repository/student_enquiry_repository.dart';

class StudentEnquiryController extends GetxController {
  final StudentEnquiryRepository _repository = StudentEnquiryRepository();

  final RxBool isLoading = false.obs;
  final RxBool isSuccess = false.obs;

  Future<bool> submitEnquiry({
    required String name,
    required String phone,
    required String studentClass,
    required String message,
  }) async {
    if (isLoading.value) return false;

    try {
      isLoading.value = true;

      final request = StudentEnquiryRequest(
        name: name,
        phone: phone,
        studentClass: studentClass,
        message: message,
      );

      final response = await _repository.createEnquiry(request);

      if (response.success) {
        isSuccess.value = true;
        FlutterToast.success(response.message.isNotEmpty
            ? response.message
            : "Enquiry submitted successfully");
        return true;
      } else {
        FlutterToast.error(response.message.isNotEmpty
            ? response.message
            : "Something went wrong");
        return false;
      }
    } catch (e) {
      FlutterToast.error(e.toString().replaceFirst("Exception: ", ""));
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}