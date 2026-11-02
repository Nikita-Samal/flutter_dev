
import '../model/family_member.dart';

abstract class FamilyMemberState {
  const FamilyMemberState();
}

class FamilyMemberInitial extends FamilyMemberState {
  const FamilyMemberInitial();
}

class FamilyMemberLoading extends FamilyMemberState {
  const FamilyMemberLoading();
}

class FamilyMemberLoaded extends FamilyMemberState {
  final List<FamilyMember> members;

  const FamilyMemberLoaded(this.members);
}

class FamilyMemberError extends FamilyMemberState {
  final String message;

  const FamilyMemberError(this.message);
}