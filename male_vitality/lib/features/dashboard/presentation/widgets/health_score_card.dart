import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../common/colors/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/dashboard_data.dart';

/// Large Personalized Health Score Card with Custom Arc Gauge
class HealthScoreCard extends StatelessWidget {
  final HealthScore healthScore;

  const HealthScoreCard({super.key, required this.healthScore});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.primary,
            Color(0xFF132A45),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 28.0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Top Row: Header & Rating Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MALE VITALITY INDEX',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.secondary300,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        fontSize: 10.5,
                      ),
                    ),
                    const SizedBox(height: 3.0),
                    Text(
                      'Personalized Health Score',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 15.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.2),
                  borderRadius: AppSpacing.roundedFull,
                  border: Border.all(
                    color: AppColors.secondary.withValues(alpha: 0.5),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  healthScore.ratingLabel,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.secondary200,
                    fontWeight: FontWeight.w700,
                    fontSize: 11.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),

          // Center Arc Gauge & Numerical Hero Score
          SizedBox(
            width: 220.0,
            height: 150.0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(220.0, 150.0),
                  painter: _HealthScoreGaugePainter(
                    score: healthScore.overallScore.toDouble(),
                    maxScore: 100.0,
                  ),
                ),
                Positioned(
                  bottom: 14.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '${healthScore.overallScore}',
                            style: AppTextStyles.displayLarge.copyWith(
                              fontSize: 54.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              height: 1.0,
                              letterSpacing: -1.0,
                            ),
                          ),
                          Text(
                            '/100',
                            style: AppTextStyles.titleMedium.copyWith(
                              color: AppColors.primary200,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        healthScore.percentileText,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.primary100.withValues(alpha: 0.9),
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),

          // Divider
          Container(
            height: 1.0,
            color: Colors.white.withValues(alpha: 0.1),
          ),
          const SizedBox(height: 14.0),

          // 4 Domain Subsystem Clean Pill Badges
          Row(
            children: [
              Expanded(
                child: _buildSubsystemPill(
                  label: 'Endocrine',
                  percentage: healthScore.endocrinePercentage,
                  color: AppColors.endocrine,
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: _buildSubsystemPill(
                  label: 'Cardio',
                  percentage: healthScore.cardiovascularPercentage,
                  color: AppColors.cardiovascular,
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: _buildSubsystemPill(
                  label: 'Sleep',
                  percentage: healthScore.sleepRecoveryPercentage,
                  color: AppColors.sleep,
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: _buildSubsystemPill(
                  label: 'Metabolic',
                  percentage: healthScore.metabolicPercentage,
                  color: AppColors.nutrition,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubsystemPill({
    required String label,
    required double percentage,
    required Color color,
  }) {
    final int scoreText = (percentage * 100).round();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 5.0,
                height: 5.0,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4.0),
              Flexible(
                child: Text(
                  label,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.primary200,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3.0),
          Text(
            '$scoreText%',
            style: AppTextStyles.labelLarge.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom Gauge Painter for Radial Health Score Arc
class _HealthScoreGaugePainter extends CustomPainter {
  final double score;
  final double maxScore;

  _HealthScoreGaugePainter({
    required this.score,
    required this.maxScore,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height - 10.0);
    final radius = (size.width / 2) - 16.0;

    // Start angle: -190 degrees, Sweep: 200 degrees
    const startAngle = math.pi * 0.95;
    const sweepAngle = math.pi * 1.1;

    // Background track
    final trackPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.14)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      trackPaint,
    );

    // Active progress arc
    final progressFraction = (score / maxScore).clamp(0.0, 1.0);
    final activeSweep = sweepAngle * progressFraction;

    final progressGradient = const SweepGradient(
      startAngle: startAngle,
      endAngle: startAngle + sweepAngle,
      colors: [
        AppColors.secondary300,
        AppColors.secondary,
        AppColors.success,
      ],
    ).createShader(Rect.fromCircle(center: center, radius: radius));

    final progressPaint = Paint()
      ..shader = progressGradient
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      activeSweep,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _HealthScoreGaugePainter oldDelegate) {
    return oldDelegate.score != score || oldDelegate.maxScore != maxScore;
  }
}
