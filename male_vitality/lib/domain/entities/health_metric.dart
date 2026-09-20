import 'package:equatable/equatable.dart';

/// Clinical Category of Health Metric
enum HealthMetricType {
  totalTestosterone(label: 'Total Testosterone', defaultUnit: 'ng/dL'),
  freeTestosterone(label: 'Free Testosterone', defaultUnit: 'pg/mL'),
  systolicBp(label: 'Systolic Blood Pressure', defaultUnit: 'mmHg'),
  diastolicBp(label: 'Diastolic Blood Pressure', defaultUnit: 'mmHg'),
  restingHeartRate(label: 'Resting Heart Rate', defaultUnit: 'bpm'),
  fastingGlucose(label: 'Fasting Blood Glucose', defaultUnit: 'mg/dL'),
  psa(label: 'Prostate-Specific Antigen', defaultUnit: 'ng/mL'),
  hrv(label: 'Heart Rate Variability', defaultUnit: 'ms'),
  bodyFatPercentage(label: 'Body Fat', defaultUnit: '%'),
  weight(label: 'Weight', defaultUnit: 'kg');

  final String label;
  final String defaultUnit;

  const HealthMetricType({required this.label, required this.defaultUnit});
}

/// Clinical Evaluation Status for Biomarkers
enum MetricStatus {
  optimal,
  normal,
  borderline,
  abnormal,
  critical,
}

/// Health Metric Domain Entity
/// Represents an individual clinical biomarker or daily biometric measurement.
/// Pure Dart (zero Flutter/Firebase dependencies).
class HealthMetric extends Equatable {
  final String id;
  final String userId;
  final HealthMetricType type;
  final double value;
  final String unit;
  final MetricStatus status;
  final DateTime recordedAt;
  final String? notes;

  const HealthMetric({
    required this.id,
    required this.userId,
    required this.type,
    required this.value,
    required this.unit,
    required this.status,
    required this.recordedAt,
    this.notes,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        type,
        value,
        unit,
        status,
        recordedAt,
        notes,
      ];
}
