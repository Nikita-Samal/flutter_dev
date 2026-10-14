import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_family_card/pages/family_page.dart';
import 'package:profile_family_card/theme/app_theme.dart';

import 'bloc/family_member_bloc.dart';
import 'bloc/family_member_event.dart';



// void main() {
//   runApp(
//     BlocProvider(
//       create: (_) => CounterCubit(),
//       child:  MyApp(),
//     ),
//   );
// }

void main() {
  runApp(
    BlocProvider(
      create: (_) => FamilyMemberBloc()
        ..add(const LoadFamilyMembers()),
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Family Members',

      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,

      home: const FamilyPage(),
    );
  }
}