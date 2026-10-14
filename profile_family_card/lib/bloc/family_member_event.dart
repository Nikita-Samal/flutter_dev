abstract class FamilyMemberEvent {
  const FamilyMemberEvent();
}

class LoadFamilyMembers extends FamilyMemberEvent {
  const LoadFamilyMembers();
}

class SearchFamilyMembers extends FamilyMemberEvent {
  final String query;

  const SearchFamilyMembers(this.query);
}