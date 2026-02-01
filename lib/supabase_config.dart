import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static Future<void> init() async {
    await Supabase.initialize(
      url: 'https://uefnlqezwbpbqqvagmgu.supabase.co',
      anonKey: 'sb_publishable_wsdg6Ubv9NZgvJLR1Axx_A_5GfQovft',
    );
  }

  static SupabaseClient get client =>
      Supabase.instance.client;
}