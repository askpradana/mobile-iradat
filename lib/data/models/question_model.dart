import '../../domain/entities/question.dart';

abstract class QuestionModel extends Question {
  const QuestionModel({
    required super.questionNumber,
    required super.questionContent,
  });
  
  factory QuestionModel.fromJson(Map<String, dynamic> json, {String questionType = 'yesno'}) {
    switch (questionType.toLowerCase()) {
      case 'slider':
        return SliderQuestionModel.fromJson(json);
      case 'likert':
        return LikertQuestionModel.fromJson(json);
      default:
        return YesNoQuestionModel.fromJson(json);
    }
  }
  
  Map<String, dynamic> toJson();
}

class YesNoQuestionModel extends QuestionModel {
  const YesNoQuestionModel({
    required super.questionNumber,
    required super.questionContent,
  });
  
  factory YesNoQuestionModel.fromJson(Map<String, dynamic> json) {
    return YesNoQuestionModel(
      questionNumber: json['questionNumber'] as int,
      questionContent: json['questionContent'] as String,
    );
  }
  
  factory YesNoQuestionModel.fromEntity(YesNoQuestion question) {
    return YesNoQuestionModel(
      questionNumber: question.questionNumber,
      questionContent: question.questionContent,
    );
  }
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'questionNumber': questionNumber,
      'questionContent': questionContent,
    };
  }
}

class SliderQuestionModel extends QuestionModel {
  final int minValue;
  final int maxValue;
  final String? minLabel;
  final String? maxLabel;
  
  const SliderQuestionModel({
    required super.questionNumber,
    required super.questionContent,
    this.minValue = 0,
    this.maxValue = 10,
    this.minLabel,
    this.maxLabel,
  });
  
  factory SliderQuestionModel.fromJson(Map<String, dynamic> json) {
    return SliderQuestionModel(
      questionNumber: json['questionNumber'] as int,
      questionContent: json['questionContent'] as String,
      minValue: json['minValue'] as int? ?? 0,
      maxValue: json['maxValue'] as int? ?? 10,
      minLabel: json['minLabel'] as String?,
      maxLabel: json['maxLabel'] as String?,
    );
  }
  
  factory SliderQuestionModel.fromEntity(SliderQuestion question) {
    return SliderQuestionModel(
      questionNumber: question.questionNumber,
      questionContent: question.questionContent,
      minValue: question.minValue,
      maxValue: question.maxValue,
      minLabel: question.minLabel,
      maxLabel: question.maxLabel,
    );
  }
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'questionNumber': questionNumber,
      'questionContent': questionContent,
      'minValue': minValue,
      'maxValue': maxValue,
      'minLabel': minLabel,
      'maxLabel': maxLabel,
    };
  }
  
  @override
  List<Object?> get props => [
    questionNumber,
    questionContent,
    minValue,
    maxValue,
    minLabel,
    maxLabel,
  ];
}

class LikertQuestionModel extends QuestionModel {
  final List<String> options;
  final int minValue;
  final int maxValue;
  
  const LikertQuestionModel({
    required super.questionNumber,
    required super.questionContent,
    this.options = const ['Tidak Pernah', 'Kadang-kadang', 'Sering', 'Sangat Sering'],
    this.minValue = 0,
    this.maxValue = 3,
  });
  
  factory LikertQuestionModel.fromJson(Map<String, dynamic> json) {
    return LikertQuestionModel(
      questionNumber: json['questionNumber'] as int,
      questionContent: json['questionContent'] as String,
      options: json['options'] != null 
          ? List<String>.from(json['options']) 
          : ['Tidak Pernah', 'Kadang-kadang', 'Sering', 'Sangat Sering'],
      minValue: json['minValue'] as int? ?? 0,
      maxValue: json['maxValue'] as int? ?? 3,
    );
  }
  
  factory LikertQuestionModel.fromEntity(LikertQuestion question) {
    return LikertQuestionModel(
      questionNumber: question.questionNumber,
      questionContent: question.questionContent,
      options: question.options,
      minValue: question.minValue,
      maxValue: question.maxValue,
    );
  }
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'questionNumber': questionNumber,
      'questionContent': questionContent,
      'options': options,
      'minValue': minValue,
      'maxValue': maxValue,
    };
  }
  
  @override
  List<Object?> get props => [
    questionNumber,
    questionContent,
    options,
    minValue,
    maxValue,
  ];
}

class QuestionListModel {
  final List<QuestionModel> questions;
  
  const QuestionListModel({required this.questions});
  
  factory QuestionListModel.fromJson(Map<String, dynamic> json, {String questionType = 'yesno'}) {
    final questionsJson = json['quizzes'] as List<dynamic>;
    final questions = questionsJson
        .map((questionJson) => QuestionModel.fromJson(
              questionJson as Map<String, dynamic>,
              questionType: questionType,
            ))
        .toList();
    
    return QuestionListModel(questions: questions);
  }
  
  Map<String, dynamic> toJson() {
    return {
      'quizzes': questions.map((question) => question.toJson()).toList(),
    };
  }
}