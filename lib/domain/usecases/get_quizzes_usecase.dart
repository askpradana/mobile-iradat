import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/quiz.dart';
import '../repositories/quiz_repository.dart';
import 'base_usecase.dart';

class GetQuizzesUseCase extends UseCaseWithoutParams<List<Quiz>> {
  final QuizRepository repository;
  
  GetQuizzesUseCase(this.repository);
  
  @override
  Future<Either<Failure, List<Quiz>>> call() async {
    return await repository.getAllQuizzes();
  }
}