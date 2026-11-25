import 'package:get/get.dart';
import '../controller/student_enquiry_controller.dart';

class StudentEnquiryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentEnquiryController>(
          () => StudentEnquiryController(),
    );
  }
}