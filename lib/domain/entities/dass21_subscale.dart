import 'base_entity.dart';

class Dass21Subscale extends BaseEntity {
  final String name;
  final int score;
  final String severity;
  final String description;
  
  const Dass21Subscale({
    required this.name,
    required this.score,
    required this.severity,
    required this.description,
  });
  
  @override
  List<Object?> get props => [name, score, severity, description];
  
  static String getSeverityLevel(String subscaleName, int score) {
    switch (subscaleName.toLowerCase()) {
      case 'depresi':
      case 'depression':
        if (score <= 9) return 'Normal';
        if (score <= 13) return 'Ringan';
        if (score <= 20) return 'Sedang';
        if (score <= 27) return 'Berat';
        return 'Sangat berat';
      
      case 'kecemasan':
      case 'anxiety':
        if (score <= 7) return 'Normal';
        if (score <= 9) return 'Ringan';
        if (score <= 14) return 'Sedang';
        if (score <= 19) return 'Berat';
        return 'Sangat berat';
      
      case 'stres':
      case 'stress':
        if (score <= 14) return 'Normal';
        if (score <= 18) return 'Ringan';
        if (score <= 25) return 'Sedang';
        if (score <= 33) return 'Berat';
        return 'Sangat berat';
      
      default:
        return 'Normal';
    }
  }
  
  static String getSeverityDescription(String subscaleName, String severity) {
    final baseDescriptions = {
      'Normal': 'Skor Anda berada dalam rentang normal.',
      'Ringan': 'Skor Anda menunjukkan tingkat ${subscaleName.toLowerCase()} yang ringan.',
      'Sedang': 'Skor Anda menunjukkan tingkat ${subscaleName.toLowerCase()} yang sedang.',
      'Berat': 'Skor Anda menunjukkan tingkat ${subscaleName.toLowerCase()} yang berat.',
      'Sangat berat': 'Skor Anda menunjukkan tingkat ${subscaleName.toLowerCase()} yang sangat berat.',
    };
    
    return baseDescriptions[severity] ?? 'Tidak ada interpretasi tersedia.';
  }
}