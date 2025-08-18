import 'package:equatable/equatable.dart';

class ReferralValidationResponse extends Equatable {
  final bool success;
  final String message;
  final String timestamp;

  const ReferralValidationResponse({
    required this.success,
    required this.message,
    required this.timestamp,
  });

  factory ReferralValidationResponse.fromJson(Map<String, dynamic> json) {
    return ReferralValidationResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      timestamp: json['timestamp'] as String,
    );
  }

  @override
  List<Object?> get props => [success, message, timestamp];
}

class AnonymousRegistrationRequest extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String organization;

  const AnonymousRegistrationRequest({
    required this.name,
    required this.email,
    required this.phone,
    required this.organization,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'organization': organization,
    };
  }

  @override
  List<Object?> get props => [name, email, phone, organization];
}

class AnonymousRegistrationResponse extends Equatable {
  final bool success;
  final String message;
  final AnonymousRegistrationData data;
  final String timestamp;

  const AnonymousRegistrationResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.timestamp,
  });

  factory AnonymousRegistrationResponse.fromJson(Map<String, dynamic> json) {
    return AnonymousRegistrationResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: AnonymousRegistrationData.fromJson(json['data'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as String,
    );
  }

  @override
  List<Object?> get props => [success, message, data, timestamp];
}

class AnonymousRegistrationData extends Equatable {
  final String status;
  final String message;
  final QuizData quiz;
  final List<QuizQuestion> questions;
  final String token;
  final String expiresAt;
  final String anonymousId;

  const AnonymousRegistrationData({
    required this.status,
    required this.message,
    required this.quiz,
    required this.questions,
    required this.token,
    required this.expiresAt,
    required this.anonymousId,
  });

  factory AnonymousRegistrationData.fromJson(Map<String, dynamic> json) {
    return AnonymousRegistrationData(
      status: json['status'] as String,
      message: json['message'] as String,
      quiz: QuizData.fromJson(json['quiz'] as Map<String, dynamic>),
      questions: (json['questions'] as List<dynamic>)
          .map((question) => QuizQuestion.fromJson(question as Map<String, dynamic>))
          .toList(),
      token: json['token'] as String,
      expiresAt: json['expires_at'] as String,
      anonymousId: json['anonymous_id'] as String,
    );
  }

  @override
  List<Object?> get props => [status, message, quiz, questions, token, expiresAt, anonymousId];
}

class QuizData extends Equatable {
  final String id;
  final String title;
  final int questions;
  final bool isAvailable;
  final bool isOpen;
  final String referralCode;
  final int timeLimit;
  final String quizType;
  final String description;
  final String createdAt;
  final String updatedAt;

  const QuizData({
    required this.id,
    required this.title,
    required this.questions,
    required this.isAvailable,
    required this.isOpen,
    required this.referralCode,
    required this.timeLimit,
    required this.quizType,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory QuizData.fromJson(Map<String, dynamic> json) {
    return QuizData(
      id: json['id'] as String,
      title: json['title'] as String,
      questions: json['questions'] as int,
      isAvailable: json['is_available'] as bool,
      isOpen: json['is_open'] as bool,
      referralCode: json['referral_code'] as String,
      timeLimit: json['time_limit'] as int,
      quizType: json['quiz_type'] as String,
      description: json['description'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  @override
  List<Object?> get props => [
    id, title, questions, isAvailable, isOpen, referralCode, 
    timeLimit, quizType, description, createdAt, updatedAt
  ];
}

class QuizQuestion extends Equatable {
  final int id;
  final int questionNumber;
  final String questionContent;
  final String quizId;

  const QuizQuestion({
    required this.id,
    required this.questionNumber,
    required this.questionContent,
    required this.quizId,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'] as int,
      questionNumber: json['question_number'] as int,
      questionContent: json['question_content'] as String,
      quizId: json['quiz_id'] as String,
    );
  }

  @override
  List<Object?> get props => [id, questionNumber, questionContent, quizId];
}

class QuizAnswer extends Equatable {
  final int questionNumber;
  final int answer;

  const QuizAnswer({
    required this.questionNumber,
    required this.answer,
  });

  Map<String, dynamic> toJson() {
    return {
      questionNumber.toString(): answer,
    };
  }

  @override
  List<Object?> get props => [questionNumber, answer];
}

class QuizSubmissionRequest extends Equatable {
  final String quizId;
  final Map<String, int> answers;
  final int timeTaken;

  const QuizSubmissionRequest({
    required this.quizId,
    required this.answers,
    required this.timeTaken,
  });

  Map<String, dynamic> toJson() {
    return {
      'quiz_id': quizId,
      'answers': answers,
      'time_taken': timeTaken,
    };
  }

  @override
  List<Object?> get props => [quizId, answers, timeTaken];
}

class QuizSubmissionResponse extends Equatable {
  final bool success;
  final String message;
  final QuizSubmissionData data;
  final String timestamp;

  const QuizSubmissionResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.timestamp,
  });

  factory QuizSubmissionResponse.fromJson(Map<String, dynamic> json) {
    return QuizSubmissionResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: QuizSubmissionData.fromJson(json['data'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as String,
    );
  }

  @override
  List<Object?> get props => [success, message, data, timestamp];
}

class QuizSubmissionData extends Equatable {
  final String id;
  final String quizId;
  final QuizScore? score;
  final String completedAt;
  final AnonymousUser user;

  const QuizSubmissionData({
    required this.id,
    required this.quizId,
    this.score,
    required this.completedAt,
    required this.user,
  });

  factory QuizSubmissionData.fromJson(Map<String, dynamic> json) {
    return QuizSubmissionData(
      id: json['id'] as String,
      quizId: json['quiz_id'] as String,
      score: json['score'] != null 
          ? QuizScore.fromJson(json['score'] as Map<String, dynamic>)
          : null,
      completedAt: json['completed_at'] as String,
      user: AnonymousUser.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => [id, quizId, score, completedAt, user];
}

class AnonymousUser extends Equatable {
  final String name;
  final String email;
  final String organizationName;
  final bool isAnonymous;

  const AnonymousUser({
    required this.name,
    required this.email,
    required this.organizationName,
    required this.isAnonymous,
  });

  factory AnonymousUser.fromJson(Map<String, dynamic> json) {
    return AnonymousUser(
      name: json['name'] as String,
      email: json['email'] as String,
      organizationName: json['organization_name'] as String,
      isAnonymous: json['is_anonymous'] as bool,
    );
  }

  @override
  List<Object?> get props => [name, email, organizationName, isAnonymous];
}

class ScoreSubscales extends Equatable {
  final int anxiety;
  final int depression;
  final int stress;

  const ScoreSubscales({
    required this.anxiety,
    required this.depression,
    required this.stress,
  });

  factory ScoreSubscales.fromJson(Map<String, dynamic> json) {
    return ScoreSubscales(
      anxiety: json['anxiety'] as int,
      depression: json['depression'] as int,
      stress: json['stress'] as int,
    );
  }

  @override
  List<Object?> get props => [anxiety, depression, stress];
}

class SeverityLevels extends Equatable {
  final String anxiety;
  final String depression;
  final String stress;

  const SeverityLevels({
    required this.anxiety,
    required this.depression,
    required this.stress,
  });

  factory SeverityLevels.fromJson(Map<String, dynamic> json) {
    return SeverityLevels(
      anxiety: json['anxiety'] as String,
      depression: json['depression'] as String,
      stress: json['stress'] as String,
    );
  }

  @override
  List<Object?> get props => [anxiety, depression, stress];
}

class QuizScore extends Equatable {
  final int totalScore;
  final int maxPossibleScore;
  final ScoreSubscales subscales;
  final SeverityLevels severityLevels;
  final String interpretation;
  final String calculatedAt;

  const QuizScore({
    required this.totalScore,
    required this.maxPossibleScore,
    required this.subscales,
    required this.severityLevels,
    required this.interpretation,
    required this.calculatedAt,
  });

  factory QuizScore.fromJson(Map<String, dynamic> json) {
    return QuizScore(
      totalScore: json['total_score'] as int,
      maxPossibleScore: json['max_possible_score'] as int,
      subscales: ScoreSubscales.fromJson(json['subscales'] as Map<String, dynamic>),
      severityLevels: SeverityLevels.fromJson(json['severity_levels'] as Map<String, dynamic>),
      interpretation: json['interpretation'] as String,
      calculatedAt: json['calculated_at'] as String,
    );
  }

  double get progressPercentage => (totalScore / maxPossibleScore * 100);

  @override
  List<Object?> get props => [
    totalScore, maxPossibleScore, subscales, severityLevels, 
    interpretation, calculatedAt
  ];
}