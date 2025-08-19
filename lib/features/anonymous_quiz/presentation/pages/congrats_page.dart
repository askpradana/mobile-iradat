import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/anonymous_quiz_controller.dart';
import '../../models.dart';

class ConfettiParticle {
  final double x;
  final double y;
  final double velocityX;
  final double velocityY;
  final double size;
  final Color color;
  final double rotation;
  final double rotationSpeed;
  final double gravity;

  ConfettiParticle({
    required this.x,
    required this.y,
    required this.velocityX,
    required this.velocityY,
    required this.size,
    required this.color,
    required this.rotation,
    required this.rotationSpeed,
    required this.gravity,
  });

  ConfettiParticle copyWith({
    double? x,
    double? y,
    double? velocityX,
    double? velocityY,
    double? rotation,
  }) {
    return ConfettiParticle(
      x: x ?? this.x,
      y: y ?? this.y,
      velocityX: velocityX ?? this.velocityX,
      velocityY: velocityY ?? this.velocityY,
      size: size,
      color: color,
      rotation: rotation ?? this.rotation,
      rotationSpeed: rotationSpeed,
      gravity: gravity,
    );
  }
}

class ConfettiPainter extends CustomPainter {
  final List<ConfettiParticle> particles;
  final double animationValue;

  ConfettiPainter({required this.particles, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      final paint =
          Paint()
            ..color = particle.color.withValues(
              alpha: 1.0 - animationValue * 0.3,
            )
            ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(particle.x, particle.y);
      canvas.rotate(particle.rotation);

      // Draw simple rectangle particle
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: particle.size,
            height: particle.size * 0.6,
          ),
          Radius.circular(particle.size * 0.1),
        ),
        paint,
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(ConfettiPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.particles.length != particles.length;
  }
}

class CongratsPage extends StatefulWidget {
  const CongratsPage({super.key});

  @override
  State<CongratsPage> createState() => _CongratsPageState();
}

class _CongratsPageState extends State<CongratsPage>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _confettiController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _confettiAnimation;

  List<ConfettiParticle> _particles = [];
  DateTime? _lastConfettiTap;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _confettiController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    // Initialize animations
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _confettiAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _confettiController, curve: Curves.easeOut),
    );

    // Listen to confetti animation for particle updates
    _confettiController.addListener(_updateParticles);

    // Start animations
    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _scaleController.forward();

    await Future.delayed(const Duration(milliseconds: 400));
    _fadeController.forward();

    await Future.delayed(const Duration(milliseconds: 200));
    _slideController.forward();

    // Start confetti animation after all main animations
    await Future.delayed(const Duration(milliseconds: 400));
    _triggerConfetti();
  }

  void _triggerConfetti() {
    _generateParticles();
    _confettiController.reset();
    _confettiController.forward();
  }

  void _generateParticles() {
    final random = Random();
    final size = MediaQuery.of(context).size;
    final colors = [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.secondary,
      Colors.green,
      Colors.orange,
      Colors.blue,
      Colors.purple,
    ];

    _particles = List.generate(35, (index) {
      return ConfettiParticle(
        x: size.width * 0.5 + (random.nextDouble() - 0.5) * 100,
        y: size.height * 0.2,
        velocityX: (random.nextDouble() - 0.5) * 300,
        velocityY: -random.nextDouble() * 200 - 100,
        size: random.nextDouble() * 5 + 3,
        color: colors[random.nextInt(colors.length)],
        rotation: random.nextDouble() * 2 * pi,
        rotationSpeed: (random.nextDouble() - 0.5) * 10,
        gravity: random.nextDouble() * 200 + 300,
      );
    });
  }

  void _updateParticles() {
    if (!mounted) return;

    final deltaTime = 0.016; // ~60fps
    final animationProgress = _confettiAnimation.value;

    setState(() {
      _particles =
          _particles
              .map((particle) {
                final newVelocityY =
                    particle.velocityY + particle.gravity * deltaTime;
                final newX = particle.x + particle.velocityX * deltaTime;
                final newY = particle.y + newVelocityY * deltaTime;
                final newRotation =
                    particle.rotation + particle.rotationSpeed * deltaTime;

                return particle.copyWith(
                  x: newX,
                  y: newY,
                  velocityY: newVelocityY,
                  rotation: newRotation,
                );
              })
              .where((particle) {
                final size = MediaQuery.of(context).size;
                return particle.y < size.height + 50 && animationProgress < 1.0;
              })
              .toList();
    });
  }

  void _onCheckIconTap() {
    final now = DateTime.now();
    if (_lastConfettiTap != null &&
        now.difference(_lastConfettiTap!) < const Duration(seconds: 3)) {
      return; // Debounced
    }

    _lastConfettiTap = now;
    _triggerConfetti();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _confettiController.removeListener(_updateParticles);
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnonymousQuizController>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Content section
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Animated success icon with tap gesture
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: GestureDetector(
                            onTap: _onCheckIconTap,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.green,
                                  width: 3,
                                ),
                              ),
                              child: const Icon(
                                Icons.check_circle,
                                size: 80,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Congratulations text
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            children: [
                              Text(
                                'Congratulations!',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              const SizedBox(height: 16),

                              Text(
                                'Quiz Completed Successfully',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 48),

                        // Quiz summary
                        SlideTransition(
                          position: _slideAnimation,
                          child: _buildQuizSummary(context, controller),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Continue button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: controller.goToLogin,
                        icon: const Icon(Icons.login),
                        label: const Text('Continue to Login'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Confetti overlay
            if (_particles.isNotEmpty)
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: ConfettiPainter(
                      particles: _particles,
                      animationValue: _confettiAnimation.value,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizSummary(
    BuildContext context,
    AnonymousQuizController controller,
  ) {
    return Obx(() {
      if (controller.submissionResult.value == null) {
        return const SizedBox.shrink();
      }

      final result = controller.submissionResult.value!;

      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Quiz summary header
              Row(
                children: [
                  Icon(
                    Icons.assignment_turned_in,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Quiz Summary',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Quiz details
              _buildSummaryRow(
                context,
                'Quiz Type',
                controller.quizData.value?.title ?? 'DASS-21',
              ),
              _buildSummaryRow(
                context,
                'Questions Answered',
                '${controller.totalAnswered} questions',
              ),
              _buildSummaryRow(
                context,
                'Time Taken',
                _formatTime(controller.elapsedTime.value),
              ),
              _buildSummaryRow(
                context,
                'Completed At',
                _formatDateTime(result.completedAt),
              ),

              // Enhanced score section
              if (result.score != null)
                _buildScoreSection(context, result.score!),

              const SizedBox(height: 12),

              // Subtle divider
              Container(
                height: 1,
                width: double.infinity,
                color: Theme.of(
                  context,
                ).colorScheme.outline.withValues(alpha: 0.12),
              ),

              const SizedBox(height: 12),

              // User information section
              _buildUserInfoSection(context, result),

              const SizedBox(height: 16),

              // Thank you message
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.green.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  'Thank you for participating in our assessment. Your responses have been recorded.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.green.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSummaryRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.end,
              overflow: TextOverflow.visible,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoSection(
    BuildContext context,
    QuizSubmissionData result,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User info header
        Row(
          children: [
            Icon(
              Icons.person_outline,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Participant Information',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // User details with icons
        _buildUserInfoRow(context, Icons.person, 'Name', result.user.name),
        _buildUserInfoRow(
          context,
          Icons.email_outlined,
          'Email',
          result.user.email,
        ),
        _buildUserInfoRow(
          context,
          Icons.business_outlined,
          'Organization',
          result.user.organizationName,
        ),
      ],
    );
  }

  Widget _buildUserInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 16,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 13,
              ),
              textAlign: TextAlign.end,
              overflow: TextOverflow.visible,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreSection(BuildContext context, QuizScore score) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),

        // Score overview header
        Row(
          children: [
            Icon(
              Icons.analytics_outlined,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Assessment Results',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Subscales breakdown
        _buildSubscalesSection(context, score),

        const SizedBox(height: 12),

        // Interpretation card
        _buildInterpretationCard(context, score),
      ],
    );
  }

  Widget _buildSubscalesSection(BuildContext context, QuizScore score) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detailed Breakdown',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),

        _buildSubscaleRow(
          context,
          'Depression',
          score.subscales.depression,
          score.severityLevels.depression,
        ),
        _buildSubscaleRow(
          context,
          'Anxiety',
          score.subscales.anxiety,
          score.severityLevels.anxiety,
        ),
        _buildSubscaleRow(
          context,
          'Stress',
          score.subscales.stress,
          score.severityLevels.stress,
        ),
      ],
    );
  }

  Widget _buildSubscaleRow(
    BuildContext context,
    String label,
    int subscaleScore,
    String severity,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
                fontSize: 13,
              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: Text(
              subscaleScore.toString(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: _buildSeverityBadge(context, severity),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeverityBadge(BuildContext context, String severity) {
    Color badgeColor;
    Color textColor;

    switch (severity.toLowerCase()) {
      case 'normal':
        badgeColor = Colors.green.withValues(alpha: 0.2);
        textColor = Colors.green.shade700;
        break;
      case 'mild':
        badgeColor = Colors.orange.withValues(alpha: 0.2);
        textColor = Colors.orange.shade700;
        break;
      case 'moderate':
        badgeColor = Colors.deepOrange.withValues(alpha: 0.2);
        textColor = Colors.deepOrange.shade700;
        break;
      case 'severe':
      case 'extremely severe':
        badgeColor = Colors.red.withValues(alpha: 0.2);
        textColor = Colors.red.shade700;
        break;
      default:
        badgeColor = Theme.of(context).colorScheme.surfaceContainerHighest;
        textColor = Theme.of(context).colorScheme.onSurface;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        severity,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _buildInterpretationCard(BuildContext context, QuizScore score) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 6),
              Text(
                'Interpretation',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            score.interpretation,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.8),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes}m ${remainingSeconds}s';
  }

  String _formatDateTime(String dateTimeStr) {
    try {
      final dateTime = DateTime.parse(dateTimeStr);
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateTimeStr;
    }
  }
}
