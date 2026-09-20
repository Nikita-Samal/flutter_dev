import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/colors/app_colors.dart';
import '../../../../common/widgets/cards/app_card.dart';
import '../../../../common/widgets/inputs/app_text_field.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';

/// Step 6: Emergency Contact & Caregiver Proxy
class Step6EmergencyContact extends StatefulWidget {
  const Step6EmergencyContact({super.key});

  @override
  State<Step6EmergencyContact> createState() => _Step6EmergencyContactState();
}

class _Step6EmergencyContactState extends State<Step6EmergencyContact> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;

  static const List<String> _relationships = [
    'Spouse / Partner',
    'Adult Child',
    'Parent / Guardian',
    'Healthcare Proxy',
    'Close Friend',
  ];

  @override
  void initState() {
    super.initState();
    final state = context.read<OnboardingBloc>().state;
    _nameController = TextEditingController(text: state.emergencyContactName);
    _phoneController = TextEditingController(text: state.emergencyContactPhone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _notifyUpdate(String relationship) {
    context.read<OnboardingBloc>().add(
          EmergencyContactUpdated(
            name: _nameController.text.trim(),
            phone: _phoneController.text.trim(),
            relationship: relationship,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Emergency Contact & Proxy',
                style: AppTextStyles.displaySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              AppSpacing.verticalSm,
              Text(
                'Used exclusively for critical diagnostic alerts or telehealth emergencies. Can be updated anytime in your profile settings.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.slate600,
                ),
              ),
              AppSpacing.verticalXl,

              AppCard(
                padding: AppSpacing.cardPaddingRelaxed,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextField(
                      controller: _nameController,
                      label: 'Contact Full Name',
                      hintText: 'e.g. Sarah Vance',
                      prefixIcon: const Icon(
                        Icons.person_outline_rounded,
                        color: AppColors.slate400,
                        size: 20.0,
                      ),
                      onChanged: (_) => _notifyUpdate(state.emergencyContactRelationship),
                    ),
                    AppSpacing.verticalMd,

                    AppTextField(
                      controller: _phoneController,
                      label: 'Emergency Phone Number',
                      hintText: '+1 (555) 000-0000',
                      keyboardType: TextInputType.phone,
                      prefixIcon: const Icon(
                        Icons.phone_outlined,
                        color: AppColors.slate400,
                        size: 20.0,
                      ),
                      onChanged: (_) => _notifyUpdate(state.emergencyContactRelationship),
                    ),
                    AppSpacing.verticalMd,

                    Text(
                      'Relationship',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.slate700,
                      ),
                    ),
                    AppSpacing.verticalXs,

                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: _relationships.map((rel) {
                        final isSelected = state.emergencyContactRelationship == rel;
                        return ChoiceChip(
                          label: Text(rel),
                          selected: isSelected,
                          selectedColor: AppColors.primary100,
                          labelStyle: AppTextStyles.labelSmall.copyWith(
                            color: isSelected ? AppColors.primary : AppColors.slate700,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          ),
                          onSelected: (_) => _notifyUpdate(rel),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              AppSpacing.verticalLg,

              // Clinical notice
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.shield_outlined,
                    color: AppColors.secondary,
                    size: 20.0,
                  ),
                  AppSpacing.horizontalSm,
                  Expanded(
                    child: Text(
                      'All contact information is protected under HIPAA and encrypted. This step is optional and can be skipped if you prefer.',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.slate500,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
