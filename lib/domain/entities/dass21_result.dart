import 'base_entity.dart';
import 'dass21_subscale.dart';

class Dass21Result extends BaseEntity {
  final Dass21Subscale depression;
  final Dass21Subscale anxiety;
  final Dass21Subscale stress;
  final int totalScore;
  final DateTime completedAt;
  
  const Dass21Result({
    required this.depression,
    required this.anxiety,
    required this.stress,
    required this.totalScore,
    required this.completedAt,
  });
  
  @override
  List<Object?> get props => [depression, anxiety, stress, totalScore, completedAt];
  
  List<Dass21Subscale> get subscales => [depression, anxiety, stress];
  
  String get overallSeverity {
    final severities = subscales.map((s) => s.severity).toList();
    
    if (severities.any((s) => s == 'Sangat berat')) return 'Sangat berat';
    if (severities.any((s) => s == 'Berat')) return 'Berat';
    if (severities.any((s) => s == 'Sedang')) return 'Sedang';
    if (severities.any((s) => s == 'Ringan')) return 'Ringan';
    return 'Normal';
  }
  
  String get overallInterpretation {
    final normalCount = subscales.where((s) => s.severity == 'Normal').length;
    
    if (normalCount == 3) {
      return 'Hasil Anda menunjukkan kondisi emosional yang sehat. Tingkat depresi, kecemasan, dan stres Anda berada dalam rentang normal.';
    } else if (normalCount == 2) {
      final problematicSubscale = subscales.firstWhere((s) => s.severity != 'Normal');
      return 'Secara keseluruhan kondisi emosional Anda cukup baik, namun perlu perhatian pada aspek ${problematicSubscale.name.toLowerCase()}.';
    } else {
      return 'Hasil menunjukkan beberapa area yang perlu perhatian dalam kesehatan mental Anda. Disarankan untuk berkonsultasi dengan profesional kesehatan mental.';
    }
  }
}