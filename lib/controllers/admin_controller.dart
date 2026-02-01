import 'package:get/get.dart';
import '../supabase_config.dart';

class AdminController extends GetxController {
  var questionText = ''.obs;
  var optionA = ''.obs;
  var optionB = ''.obs;
  var optionC = ''.obs;
  var correct = ''.obs;

  Future<bool> sendQuestion() async {
    // Validation
    final options = [optionA.value, optionB.value, optionC.value];
    if (!options.contains(correct.value)) {
      Get.snackbar(
        'Error',
        'Correct answer must match one of the options',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      return false;
    }

    await SupabaseConfig.client.from('questions').insert({
      'title': questionText.value,
      'type': 'multiple', // هذا السطر الإجباري
      'options': options,
      'correct_answer': correct.value,
    });

    return true;
  }
}
