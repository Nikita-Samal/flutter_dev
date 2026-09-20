import 'package:equatable/equatable.dart';

/// Relationship between User and Caregiver
enum CaregiverRelationship {
  spousePartner,
  adultChild,
  parentGuardian,
  healthcareProxy,
  professionalCaregiver,
  other,
}

/// Permissions granted to Caregiver under HIPAA / consent
enum CaregiverPermission {
  viewVitals,
  viewMedications,
  viewScreenings,
  receiveEmergencyAlerts,
  manageAppointments,
  fullClinicalAccess,
}

/// Invitation / Active status of caregiver relationship
enum CaregiverLinkStatus {
  pendingInvitation,
  active,
  revoked,
  expired,
}

/// Caregiver Link Domain Entity
/// Represents authorized third-party access (e.g. partner, adult child for 70+ life stage, or healthcare proxy).
/// Pure Dart (zero Flutter/Firebase dependencies).
class CaregiverLink extends Equatable {
  final String id;
  final String patientUserId;
  final String caregiverUserId;
  final String caregiverName;
  final String caregiverEmail;
  final CaregiverRelationship relationship;
  final List<CaregiverPermission> permissions;
  final CaregiverLinkStatus status;
  final DateTime grantedAt;
  final DateTime? expiresAt;

  const CaregiverLink({
    required this.id,
    required this.patientUserId,
    required this.caregiverUserId,
    required this.caregiverName,
    required this.caregiverEmail,
    required this.relationship,
    this.permissions = const [],
    this.status = CaregiverLinkStatus.pendingInvitation,
    required this.grantedAt,
    this.expiresAt,
  });

  /// Checks if the caregiver currently has a specific permission
  bool hasPermission(CaregiverPermission permission) {
    if (status != CaregiverLinkStatus.active) return false;
    if (expiresAt != null && DateTime.now().isAfter(expiresAt!)) return false;
    return permissions.contains(CaregiverPermission.fullClinicalAccess) ||
        permissions.contains(permission);
  }

  @override
  List<Object?> get props => [
        id,
        patientUserId,
        caregiverUserId,
        caregiverName,
        caregiverEmail,
        relationship,
        permissions,
        status,
        grantedAt,
        expiresAt,
      ];
}
