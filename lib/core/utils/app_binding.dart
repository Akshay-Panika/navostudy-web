import 'package:get/get.dart';

import '../../features/enquiry/controller/student_enquiry_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
   Get.put<StudentEnquiryController>(StudentEnquiryController(), permanent: true);
  }
}