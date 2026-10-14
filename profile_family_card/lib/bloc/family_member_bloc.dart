import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/family_member.dart';
import 'family_member_event.dart';
import 'family_member_state.dart';




class FamilyMemberBloc
    extends Bloc<FamilyMemberEvent, FamilyMemberState> {
  FamilyMemberBloc()
      : super(const FamilyMemberInitial()) {
    on<LoadFamilyMembers>(_onLoadFamilyMembers);
    on<SearchFamilyMembers>(_onSearchFamilyMembers);
  }

  final List<FamilyMember> _allMembers = const [
    FamilyMember(
      name: 'John',
      relation: 'Father',
    ),
    FamilyMember(
      name: 'Sarah',
      relation: 'Mother',
    ),
    FamilyMember(
      name: 'Michael',
      relation: 'Brother',
    ),
    FamilyMember(
      name: 'Emma',
      relation: 'Sister',
    ),
  ];

  void _onLoadFamilyMembers(
      LoadFamilyMembers event,
      Emitter<FamilyMemberState> emit,
      ) {
    emit(const FamilyMemberLoading());

    emit(FamilyMemberLoaded(_allMembers));
  }

  void _onSearchFamilyMembers(
      SearchFamilyMembers event,
      Emitter<FamilyMemberState> emit,
      ) {
    final query = event.query.trim().toLowerCase();

    if (query.isEmpty) {
      emit(FamilyMemberLoaded(_allMembers));
      return;
    }

    final filteredMembers = _allMembers.where((member) {
      return member.name.toLowerCase().contains(query) ||
          member.relation.toLowerCase().contains(query);
    }).toList();

    emit(FamilyMemberLoaded(filteredMembers));
  }
}