import 'package:flutter_dotenv/flutter_dotenv.dart';

String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
String get supabaseAPIKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';