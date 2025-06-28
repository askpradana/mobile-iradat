import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_iradat/screens/quiz/sliderquiz.dart';

class SliderQuizQuestion {
  final int questionId;
  final String questionContent;
  double? userAnswer;

  SliderQuizQuestion({
    required this.questionId,
    required this.questionContent,
    this.userAnswer,
  });
}

class SliderQuizPage extends StatefulWidget {
  final String quizTitle;
  final String quizId;

  const SliderQuizPage({
    super.key,
    required this.quizTitle,
    required this.quizId,
  });

  @override
  State<SliderQuizPage> createState() => _SliderQuizPageState();
}

class _SliderQuizPageState extends State<SliderQuizPage>
    with TickerProviderStateMixin {
  int currentQuestionIndex = 0;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  List<SliderQuizQuestion> questions = [];
  bool isLoading = true;

  Future<void> loadQuestions() async {
    try {
      final String jsonContent = await rootBundle.loadString(
        'lib/data/smfa10.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonContent);
      final List<dynamic> questionsData = jsonData['quizzes'];

      setState(() {
        questions =
            questionsData
                .map(
                  (question) => SliderQuizQuestion(
                    questionId: question['questionNumber'],
                    questionContent: question['questionContent'],
                  ),
                )
                .toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeInOut),
    );

    loadQuestions().then((_) {
      if (questions.isNotEmpty) {
        _slideController.forward();
      }
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _selectAnswer(double answer) {
    if (questions.isEmpty) return;

    setState(() {
      questions[currentQuestionIndex].userAnswer = answer;
    });
  }

  void _nextQuestion() {
    if (questions.isEmpty || currentQuestionIndex >= questions.length - 1) {
      return;
    }
    _slideController.reset();
    setState(() {
      currentQuestionIndex++;
      // Reset answer to 0 for new questions
      questions[currentQuestionIndex].userAnswer = 0;
    });
    _slideController.forward();
  }

  void _submitQuiz() {
    if (questions.isEmpty) {
      return;
    }

    // Calculate statistics for slider quiz
    double totalScore = 0;
    int answeredQuestions = 0;

    for (var question in questions) {
      if (question.userAnswer != null) {
        totalScore += question.userAnswer!;
        answeredQuestions++;
      }
    }

    double averageScore =
        answeredQuestions > 0 ? totalScore / answeredQuestions : 0;

    // Navigate to results page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => SliderQuizResultsPage(
              quizTitle: widget.quizTitle,
              quizId: widget.quizId,
              questions: questions,
              averageScore: averageScore,
              totalScore: totalScore,
            ),
      ),
    );
  }

  bool get _isLastQuestion =>
      questions.isNotEmpty && currentQuestionIndex == questions.length - 1;
  bool get _canProceed =>
      questions.isNotEmpty &&
      currentQuestionIndex < questions.length &&
      questions[currentQuestionIndex].userAnswer != null;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            widget.quizTitle,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
              ),
              SizedBox(height: 16),
              Text(
                'Loading questions...',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    }

    if (questions.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            widget.quizTitle,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
              SizedBox(height: 16),
              Text(
                'Failed to load questions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Please try again',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  loadQuestions();
                },
                child: Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final currentQuestion = questions[currentQuestionIndex];
    final progress = (currentQuestionIndex + 1) / questions.length;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.quizTitle,
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Bar
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Question ${currentQuestionIndex + 1} of ${questions.length}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        "${(progress * 100).toInt()}%",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.blue[600]!,
                      ),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ),

            // Question Card
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: .1),
                          spreadRadius: 2,
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Question Icon
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.help_outline,
                            size: 32,
                            color: Colors.blue[600],
                          ),
                        ),
                        SizedBox(height: 24),

                        // Question Text
                        Text(
                          currentQuestion.questionContent,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 40),

                        // Slider Quiz Widget
                        SliderQuiz(
                          question: currentQuestion.questionContent,
                          onChanged: _selectAnswer,
                          initialValue: currentQuestion.userAnswer ?? 0,
                        ),

                        // Answer Status Indicator
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Navigation Buttons
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  // Next/Submit Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed:
                          _canProceed
                              ? (_isLastQuestion ? _submitQuiz : _nextQuestion)
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _isLastQuestion ? "Submit Quiz" : "Next",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            _isLastQuestion ? Icons.check : Icons.arrow_forward,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SliderQuizResultsPage extends StatelessWidget {
  final String quizTitle;
  final String quizId;
  final List<SliderQuizQuestion> questions;
  final double averageScore;
  final double totalScore;

  const SliderQuizResultsPage({
    super.key,
    required this.quizTitle,
    required this.quizId,
    required this.questions,
    required this.averageScore,
    required this.totalScore,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        title: Text(
          "Quiz Results",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                quizTitle,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                "Quiz #$quizId",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 32),

              // Statistics Cards
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: "Average Score",
                      value: averageScore.toStringAsFixed(1),
                      subtitle: "out of 10",
                      color: Colors.blue,
                      icon: Icons.analytics,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      title: "Total Score",
                      value: totalScore.toStringAsFixed(1),
                      subtitle: "points",
                      color: Colors.green,
                      icon: Icons.score,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Total Questions Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.quiz,
                        color: Colors.orange[600],
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Questions Completed",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            "${questions.length} questions",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Score Interpretation
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Score Interpretation",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      _getScoreInterpretation(averageScore),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).popUntil((route) => route.isFirst);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Back to Home",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Retake quiz functionality
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Retake Quiz",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  String _getScoreInterpretation(double score) {
    if (score >= 8.0) {
      return "Excellent! Your stress management skills are very strong. You demonstrate excellent coping mechanisms and resilience.";
    } else if (score >= 6.0) {
      return "Good! You have solid stress management abilities. There's room for improvement, but you're on the right track.";
    } else if (score >= 4.0) {
      return "Fair. You have some stress management skills, but there are areas where you could benefit from additional strategies.";
    } else {
      return "Consider developing your stress management skills. You might benefit from learning new coping strategies and techniques.";
    }
  }
}
