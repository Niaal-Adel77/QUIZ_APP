import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../supabase_config.dart';

class SignupController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;

  Future<void> signup() async {
    if (name.value.isEmpty || email.value.isEmpty || password.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      // 1. Sign up properly
      final res = await SupabaseConfig.client.auth.signUp(
        email: email.value,
        password: password.value,
        data: {'full_name': name.value, 'role': 'user'},
      );

      if (res.user != null) {
        // 2. Insert into profiles table if your Supabase logic requires it manually
        // Check if your Supabase setup has triggers. If not, insert here.
        // Assuming triggers handle it or we insert manually:

        await SupabaseConfig.client.from('profiles').insert({
          'id': res.user!.id,
          'full_name': name.value,
          'role': 'user',
          'email': email.value,
        });

        Get.snackbar(
          'Success',
          'Account created successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Go back to login or auto-login
        Get.back();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
