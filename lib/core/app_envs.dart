import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnvs {
  static final String dev = dotenv.get("APP_NAME");
  static final String apiURL = dotenv.get("API_URL");
  static final String supabaseKey = dotenv.get("SUPABASE_KEY");
}