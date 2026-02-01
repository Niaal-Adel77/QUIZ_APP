import 'package:get/get.dart';
import '../supabase_config.dart';

class AuthController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;

  Future<String> login() async {
    final res = await SupabaseConfig.client.auth
        .signInWithPassword(
      email: email.value,
      password: password.value,
    );

    final userId = res.user!.id;

    final profile = await SupabaseConfig.client
        .from('profiles')
        .select('role')
        .eq('id', userId)
        .single();

    return profile['role'];
  }
}