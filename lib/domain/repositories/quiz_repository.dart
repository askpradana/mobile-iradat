import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/quiz.dart';
import '../entities/question.dart';

abstract class QuizRepository {
  Future<Either<Failure, List<Quiz>>> getAllQuizzes();
  Future<Either<Failure, Quiz>> getQuizById(String id);
  Future<Either<Failure, List<Question>>> getQuizQuestions(String quizId);
  Future<Either<Failure, void>> saveQuizResponse(String quizId, List<Map<String, dynamic>> responses);
}