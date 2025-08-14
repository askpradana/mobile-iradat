import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../core/errors/exceptions.dart';
import '../../domain/entities/quiz.dart';
import '../../domain/entities/question.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../datasources/quiz_local_data_source.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizLocalDataSource localDataSource;
  
  QuizRepositoryImpl({required this.localDataSource});
  
  @override
  Future<Either<Failure, List<Quiz>>> getAllQuizzes() async {
    try {
      final quizzes = await localDataSource.getAllQuizzes();
      return Right(quizzes);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: $e'));
    }
  }
  
  @override
  Future<Either<Failure, Quiz>> getQuizById(String id) async {
    try {
      final quizzes = await localDataSource.getAllQuizzes();
      final quiz = quizzes.firstWhere(
        (quiz) => quiz.id == id,
        orElse: () => throw CacheException('Quiz not found'),
      );
      return Right(quiz);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: $e'));
    }
  }
  
  @override
  Future<Either<Failure, List<Question>>> getQuizQuestions(String quizId) async {
    try {
      final questions = await localDataSource.getQuizQuestions(quizId);
      return Right(questions);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: $e'));
    }
  }
  
  @override
  Future<Either<Failure, void>> saveQuizResponse(String quizId, List<Map<String, dynamic>> responses) async {
    try {
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to save quiz response: $e'));
    }
  }
}