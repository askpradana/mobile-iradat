class QuizModel {
  List<Quizzes>? quizzes;

  QuizModel({this.quizzes});

  QuizModel.fromJson(Map<String, dynamic> json) {
    if (json['quizzes'] != null) {
      quizzes = <Quizzes>[];
      json['quizzes'].forEach((v) {
        quizzes!.add(Quizzes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (quizzes != null) {
      data['quizzes'] = quizzes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Quizzes {
  String? id;
  String? title;
  int? questions;
  bool? isAvailable;
  int? timeLimit;
  String? quizType;
  String? description;

  Quizzes({
    this.id,
    this.title,
    this.questions,
    this.isAvailable,
    this.timeLimit,
    this.quizType,
    this.description,
  });

  Quizzes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    questions = json['questions'];
    isAvailable = json['isAvailable'];
    timeLimit = json['timeLimit'];
    quizType = json['quizType'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['questions'] = questions;
    data['isAvailable'] = isAvailable;
    data['timeLimit'] = timeLimit;
    data['quizType'] = quizType;
    data['description'] = description;
    return data;
  }
}
