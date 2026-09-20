/// MaleVitality 6 Life Stages & Men's Health Clinical Standards
///
/// Pure Dart definition (zero Flutter dependency) to comply with Clean Architecture.
enum LifeStage {
  adolescence(
    id: '13-17',
    label: 'Adolescence',
    ageRange: '13 - 17',
    minAge: 13,
    maxAge: 17,
    clinicalFocus: 'Pubertal development, reproductive education, postural health, and mental wellbeing.',
  ),
  youngAdult(
    id: '18-25',
    label: 'Young Adult',
    ageRange: '18 - 25',
    minAge: 18,
    maxAge: 25,
    clinicalFocus: 'Baseline fitness, reproductive wellness, substance awareness, and metabolic foundation.',
  ),
  primeVitality(
    id: '26-39',
    label: 'Prime Vitality',
    ageRange: '26 - 39',
    minAge: 26,
    maxAge: 39,
    clinicalFocus: 'Endocrine optimization, stress & cortisol regulation, body composition, cardiovascular baselines.',
  ),
  midlife(
    id: '40-54',
    label: 'Midlife Health',
    ageRange: '40 - 54',
    minAge: 40,
    maxAge: 54,
    clinicalFocus: 'Early prostate screening, lipid management, andropause mitigation, and metabolic longevity.',
  ),
  mature(
    id: '55-69',
    label: 'Mature Health',
    ageRange: '55 - 69',
    minAge: 55,
    maxAge: 69,
    clinicalFocus: 'PSA monitoring, colorectal screening, cardiovascular protection, and bone density maintenance.',
  ),
  senior(
    id: '70+',
    label: 'Senior Wellness',
    ageRange: '70+',
    minAge: 70,
    maxAge: 120,
    clinicalFocus: 'Cognitive acuity, fall prevention, joint mobility, medication review, and caregiver integration.',
  );

  const LifeStage({
    required this.id,
    required this.label,
    required this.ageRange,
    required this.minAge,
    required this.maxAge,
    required this.clinicalFocus,
  });

  final String id;
  final String label;
  final String ageRange;
  final int minAge;
  final int maxAge;
  final String clinicalFocus;

  /// Determines the appropriate LifeStage based on chronological age
  static LifeStage fromAge(int age) {
    if (age <= 17) return LifeStage.adolescence;
    if (age <= 25) return LifeStage.youngAdult;
    if (age <= 39) return LifeStage.primeVitality;
    if (age <= 54) return LifeStage.midlife;
    if (age <= 69) return LifeStage.mature;
    return LifeStage.senior;
  }
}

/// Clinical Reference Standards for Men's Health Biomarkers (Pure Dart)
abstract class BiomarkerStandards {
  // Total Testosterone (ng/dL)
  static const double testosteroneNormalMin = 300.0;
  static const double testosteroneOptimalMin = 500.0;
  static const double testosteroneOptimalMax = 900.0;
  static const double testosteroneNormalMax = 1000.0;

  // Free Testosterone (pg/mL)
  static const double freeTestosteroneNormalMin = 9.0;
  static const double freeTestosteroneNormalMax = 30.0;

  // Prostate-Specific Antigen (PSA) (ng/mL)
  static const double psaNormalMaxUnder50 = 2.5;
  static const double psaNormalMax50To59 = 3.5;
  static const double psaNormalMax60Plus = 4.0;

  // Blood Pressure Standards (mmHg)
  static const int bpSystolicNormalMax = 120;
  static const int bpDiastolicNormalMax = 80;
  static const int bpSystolicElevatedMax = 129;
  static const int bpSystolicStage1Max = 139;

  // Fasting Blood Glucose (mg/dL)
  static const double fastingGlucoseNormalMin = 70.0;
  static const double fastingGlucoseNormalMax = 99.0;
  static const double fastingGlucosePreDiabeticMax = 125.0;

  // Resting Heart Rate (bpm)
  static const int restingHrNormalMin = 55;
  static const int restingHrNormalMax = 80;

  // Sleep Duration Target (hours)
  static const double sleepTargetMinHours = 7.0;
  static const double sleepTargetMaxHours = 9.0;
}
