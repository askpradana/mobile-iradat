import '../entities/base_entity.dart';

abstract class QuestionResponse extends BaseEntity {
  final int questionNumber;
  
  const QuestionResponse({required this.questionNumber});
  
  @override
  List<Object?> get props => [questionNumber];
}

class YesNoResponse extends QuestionResponse {
  final bool response;
  
  const YesNoResponse({
    required super.questionNumber,
    required this.response,
  });
  
  @override
  List<Object?> get props => [questionNumber, response];
}

class SliderResponse extends QuestionResponse {
  final double value;
  
  const SliderResponse({
    required super.questionNumber,
    required this.value,
  });
  
  @override
  List<Object?> get props => [questionNumber, value];
}

class QuizResponse extends BaseEntity {
  final String quizId;
  final String userId;
  final List<QuestionResponse> responses;
  final DateTime completedAt;
  final int? score;
  
  const QuizResponse({
    required this.quizId,
    required this.userId,
    required this.responses,
    required this.completedAt,
    this.score,
  });
  
  @override
  List<Object?> get props => [quizId, userId, responses, completedAt, score];
}