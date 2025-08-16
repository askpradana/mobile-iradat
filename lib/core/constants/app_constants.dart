import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static final String baseUrl = dotenv.env['BACKEND_BASE_URL']!;
  static const String quizzesJsonPath = 'lib/data/quizzes.json';
  static const String srq20JsonPath = 'lib/data/srq20.json';
  static const String smfa10JsonPath = 'lib/data/smfa10.json';
  static const String dass21JsonPath = 'lib/data/dass21.json';
}
