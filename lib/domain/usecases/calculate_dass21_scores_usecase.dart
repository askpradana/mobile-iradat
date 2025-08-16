import 'package:dartz/dartz.dart';
import '../entities/dass21_result.dart';
import '../entities/dass21_subscale.dart';
import '../../core/errors/failures.dart';
import 'base_usecase.dart';

class CalculateDass21ScoresParams {
  final List<int> responses;
  
  const CalculateDass21ScoresParams({required this.responses});
}

class CalculateDass21ScoresUseCase extends UseCase<Dass21Result, CalculateDass21ScoresParams> {
  @override
  Future<Either<Failure, Dass21Result>> call(CalculateDass21ScoresParams params) async {
    try {
      // Validate input
      if (params.responses.length != 21) {
        return Left(ValidationFailure('DASS-21 requires exactly 21 responses'));
      }
      
      // Validate response values (should be 0-3)
      if (params.responses.any((response) => response < 0 || response > 3)) {
        return Left(ValidationFailure('All responses must be between 0 and 3'));
      }
      
      // Calculate subscale scores
      final depressionScore = _calculateSubscaleScore(params.responses, 1, 7);
      final anxietyScore = _calculateSubscaleScore(params.responses, 8, 14);
      final stressScore = _calculateSubscaleScore(params.responses, 15, 21);
      
      // Create subscale objects
      final depression = Dass21Subscale(
        name: 'Depresi',
        score: depressionScore,
        severity: Dass21Subscale.getSeverityLevel('depresi', depressionScore),
        description: Dass21Subscale.getSeverityDescription('depresi', 
          Dass21Subscale.getSeverityLevel('depresi', depressionScore)),
      );
      
      final anxiety = Dass21Subscale(
        name: 'Kecemasan',
        score: anxietyScore,
        severity: Dass21Subscale.getSeverityLevel('kecemasan', anxietyScore),
        description: Dass21Subscale.getSeverityDescription('kecemasan',
          Dass21Subscale.getSeverityLevel('kecemasan', anxietyScore)),
      );
      
      final stress = Dass21Subscale(
        name: 'Stres',
        score: stressScore,
        severity: Dass21Subscale.getSeverityLevel('stres', stressScore),
        description: Dass21Subscale.getSeverityDescription('stres',
          Dass21Subscale.getSeverityLevel('stres', stressScore)),
      );
      
      // Create result object
      final result = Dass21Result(
        depression: depression,
        anxiety: anxiety,
        stress: stress,
        totalScore: depressionScore + anxietyScore + stressScore,
        completedAt: DateTime.now(),
      );
      
      return Right(result);
      
    } catch (e) {
      return Left(ServerFailure('Failed to calculate DASS-21 scores: ${e.toString()}'));
    }
  }
  
  int _calculateSubscaleScore(List<int> responses, int startQuestion, int endQuestion) {
    int score = 0;
    for (int i = startQuestion - 1; i < endQuestion; i++) {
      score += responses[i];
    }
    return score;
  }
}