import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../common/colors/app_colors.dart';
import '../../../../common/widgets/cards/app_card.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';

/// Step 2: Date of Birth & Real-time Life Stage Calculation
class Step2DateOfBirth extends StatelessWidget {
  const Step2DateOfBirth({super.key});

  Future<void> _selectDate(BuildContext context, DateTime currentDate) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1920),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 13)), // Min age 13
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && context.mounted) {
      context.read<OnboardingBloc>().add(DateOfBirthChanged(pickedDate));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        final dobFormatted = DateFormat('MMMM dd, yyyy').format(state.dateOfBirth);
        final stage = state.calculatedLifeStage;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'When were you born?',
                style: AppTextStyles.displaySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              AppSpacing.verticalSm,
              Text(
                'Your exact date of birth allows us to calibrate hormonal reference intervals and screening protocols.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.slate600,
                ),
              ),
              AppSpacing.verticalXl,

              // Date Picker Card
              AppCard(
                padding: AppSpacing.cardPaddingRelaxed,
                onTap: () => _selectDate(context, state.dateOfBirth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date of Birth',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.slate500,
                      ),
                    ),
                    AppSpacing.verticalSm,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                padding: AppSpacing.insetAllSm,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary100,
                                  borderRadius: AppSpacing.roundedSm,
                                ),
                                child: const Icon(
                                  Icons.calendar_today_rounded,
                                  color: AppColors.primary,
                                  size: 20.0,
                                ),
                              ),
                              AppSpacing.horizontalMd,
                              Expanded(
                                child: Text(
                                  dobFormatted,
                                  style: AppTextStyles.headlineSmall.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                          decoration: BoxDecoration(
                            color: AppColors.secondary.withValues(alpha: 0.1),
                            borderRadius: AppSpacing.roundedSm,
                          ),
                          child: Text(
                            'Edit',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppSpacing.verticalLg,

              // Dynamically Computed Clinical Life Stage Card
              Container(
                width: double.infinity,
                padding: AppSpacing.cardPaddingRelaxed,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary800,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: AppSpacing.roundedLg,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.18),
                      blurRadius: 16.0,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8.0,
                      runSpacing: 6.0,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                          decoration: const BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: AppSpacing.roundedFull,
                          ),
                          child: Text(
                            'CALCULATED LIFE STAGE',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                            ),
                          ),
                        ),
                        Text(
                          'Age: ${state.calculatedAge} yrs',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.verticalMd,
                    Text(
                      stage.label,
                      style: AppTextStyles.headlineLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    AppSpacing.verticalXs,
                    Text(
                      'Clinical Target Range: ${stage.ageRange}',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.secondary200,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    AppSpacing.verticalMd,
                    Text(
                      stage.clinicalFocus,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary100,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
