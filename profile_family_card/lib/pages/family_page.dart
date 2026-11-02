import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../bloc/family_member_bloc.dart';
import '../bloc/family_member_event.dart';
import '../bloc/family_member_state.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/family_member_card.dart';
import '../theme/app_spacing.dart';

class FamilyPage extends StatelessWidget {
  const FamilyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Members'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 700;

          return SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 1000,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                    children: [
                      ZmlAppTextField(
                        hintText: 'Search family members',
                        onChanged: (value) {
                          context
                              .read<FamilyMemberBloc>()
                              .add(
                            SearchFamilyMembers(value),
                          );
                        }, label: '',
                      ),

                      const SizedBox(
                        height: AppSpacing.lg,
                      ),

                      BlocBuilder<FamilyMemberBloc,
                          FamilyMemberState>(
                        builder: (context, state) {
                          if (state is FamilyMemberLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state is FamilyMemberError) {
                            return Center(
                              child: Text(state.message),
                            );
                          }

                          if (state is FamilyMemberLoaded) {
                            if (state.members.isEmpty) {
                              return const Center(
                                child: Text(
                                  'No family members found.',
                                ),
                              );
                            }

                            if (isWide) {
                              return GridView.builder(
                                shrinkWrap: true,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                itemCount: state.members.length,
                                gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 480,
                                  mainAxisExtent: 120,
                                  crossAxisSpacing: AppSpacing.md,
                                  mainAxisSpacing: AppSpacing.md,
                                ),
                                itemBuilder: (context, index) {
                                  return FamilyMemberCard(
                                    member: state.members[index], name: '', relation: '',
                                  );
                                },
                              );
                            }

                            return Column(
                              children: state.members.map(
                                    (member) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: AppSpacing.md,
                                    ),
                                    child: FamilyMemberCard(
                                      member: member, name: '', relation: '',
                                    ),
                                  );
                                },
                              ).toList(),
                            );
                          }

                          return const SizedBox.shrink();
                        },
                      ),

                      const SizedBox(
                        height: AppSpacing.lg,
                      ),

                      if (isWide)
                        Row(
                          children: [
                            Expanded(
                              child: ZmlAppButton(
                                label: 'Add Member',
                                intent: ButtonIntent.add,
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(
                              width: AppSpacing.md,
                            ),
                            Expanded(
                              child: ZmlAppButton(
                                label: 'Save',
                                intent: ButtonIntent.save,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        )
                      else
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.stretch,
                          children: [
                            ZmlAppButton(
                              label: 'Add Member',
                              intent: ButtonIntent.add,
                              onPressed: () {},
                            ),
                            const SizedBox(
                              height: AppSpacing.md,
                            ),
                            ZmlAppButton(
                              label: 'Save',
                              intent: ButtonIntent.save,
                              onPressed: () {},
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}