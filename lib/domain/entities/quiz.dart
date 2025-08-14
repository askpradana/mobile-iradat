import '../entities/base_entity.dart';

enum QuizType { yesno, slider }

class Quiz extends BaseEntity {
  final String id;
  final String title;
  final int questions;
  final bool isAvailable;
  final int timeLimit;
  final QuizType quizType;
  final String description;
  
  const Quiz({
    required this.id,
    required this.title,
    required this.questions,
    required this.isAvailable,
    required this.timeLimit,
    required this.quizType,
    required this.description,
  });
  
  @override
  List<Object?> get props => [
    id,
    title,
    questions,
    isAvailable,
    timeLimit,
    quizType,
    description,
  ];
}