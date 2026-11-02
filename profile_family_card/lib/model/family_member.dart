class FamilyMember {
  final String name;
  final String relation;
  final String? avatarUrl;

  const FamilyMember({
    required this.name,
    required this.relation,
    this.avatarUrl,
  });
}