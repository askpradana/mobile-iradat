import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../core/errors/failures.dart';
import '../entities/question.dart';
import '../repositories/quiz_repository.dart';
import 'base_usecase.dart';

class GetQuizQuestionsUseCase extends UseCase<List<Question>, QuizQuestionsParams> {
  final QuizRepository repository;
  
  GetQuizQuestionsUseCase(this.repository);
  
  @override
  Future<Either<Failure, List<Question>>> call(QuizQuestionsParams params) async {
    return await repository.getQuizQuestions(params.quizId);
  }
}

class QuizQuestionsParams extends Equatable {
  final String quizId;
  
  const QuizQuestionsParams({required this.quizId});
  
  @override
  List<Object> get props => [quizId];
}