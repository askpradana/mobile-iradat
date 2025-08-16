import '../../domain/entities/quiz.dart';

class QuizModel extends Quiz {
  const QuizModel({
    required super.id,
    required super.title,
    required super.questions,
    required super.isAvailable,
    required super.timeLimit,
    required super.quizType,
    required super.description,
  });
  
  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] as String,
      title: json['title'] as String,
      questions: json['questions'] as int,
      isAvailable: json['isAvailable'] as bool,
      timeLimit: json['timeLimit'] as int,
      quizType: _parseQuizType(json['quizType'] as String),
      description: json['description'] as String,
    );
  }
  
  factory QuizModel.fromEntity(Quiz quiz) {
    return QuizModel(
      id: quiz.id,
      title: quiz.title,
      questions: quiz.questions,
      isAvailable: quiz.isAvailable,
      timeLimit: quiz.timeLimit,
      quizType: quiz.quizType,
      description: quiz.description,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'questions': questions,
      'isAvailable': isAvailable,
      'timeLimit': timeLimit,
      'quizType': _quizTypeToString(quizType),
      'description': description,
    };
  }
  
  static QuizType _parseQuizType(String quizTypeString) {
    switch (quizTypeString.toLowerCase()) {
      case 'yesno':
        return QuizType.yesno;
      case 'slider':
        return QuizType.slider;
      case 'likert':
        return QuizType.likert;
      default:
        return QuizType.yesno;
    }
  }
  
  static String _quizTypeToString(QuizType quizType) {
    switch (quizType) {
      case QuizType.yesno:
        return 'yesno';
      case QuizType.slider:
        return 'slider';
      case QuizType.likert:
        return 'likert';
    }
  }
}

class QuizListModel {
  final List<QuizModel> quizzes;
  
  const QuizListModel({required this.quizzes});
  
  factory QuizListModel.fromJson(Map<String, dynamic> json) {
    final quizzesJson = json['quizzes'] as List<dynamic>;
    final quizzes = quizzesJson
        .map((quizJson) => QuizModel.fromJson(quizJson as Map<String, dynamic>))
        .toList();
    
    return QuizListModel(quizzes: quizzes);
  }
  
  Map<String, dynamic> toJson() {
    return {
      'quizzes': quizzes.map((quiz) => quiz.toJson()).toList(),
    };
  }
}