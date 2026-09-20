import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:male_vitality/core/constants/life_stage_constants.dart';
import 'package:male_vitality/core/services/firebase_service.dart';
import 'package:male_vitality/data/models/user_profile_model.dart';
import 'package:male_vitality/domain/entities/user_profile.dart';
import 'package:male_vitality/features/auth/data/repositories/mock_auth_repository.dart';
import 'package:male_vitality/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:male_vitality/features/auth/presentation/screens/login_screen.dart';
import 'package:male_vitality/features/auth/presentation/screens/signup_screen.dart';
import 'package:male_vitality/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:male_vitality/features/dashboard/data/repositories/mock_dashboard_repository.dart';
import 'package:male_vitality/features/dashboard/domain/entities/dashboard_data.dart';
import 'package:male_vitality/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:male_vitality/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:male_vitality/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:male_vitality/features/dashboard/presentation/screens/home_dashboard_screen.dart';
import 'package:male_vitality/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:male_vitality/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'package:male_vitality/main.dart';

void main() {
  group('LifeStage Clinical Calculation', () {
    test('Calculates the exact 6 life stages based on chronological age', () {
      expect(LifeStage.fromAge(15), equals(LifeStage.adolescence));
      expect(LifeStage.fromAge(17), equals(LifeStage.adolescence));

      expect(LifeStage.fromAge(18), equals(LifeStage.youngAdult));
      expect(LifeStage.fromAge(25), equals(LifeStage.youngAdult));

      expect(LifeStage.fromAge(26), equals(LifeStage.primeVitality));
      expect(LifeStage.fromAge(39), equals(LifeStage.primeVitality));

      expect(LifeStage.fromAge(40), equals(LifeStage.midlife));
      expect(LifeStage.fromAge(54), equals(LifeStage.midlife));

      expect(LifeStage.fromAge(55), equals(LifeStage.mature));
      expect(LifeStage.fromAge(69), equals(LifeStage.mature));

      expect(LifeStage.fromAge(70), equals(LifeStage.senior));
      expect(LifeStage.fromAge(85), equals(LifeStage.senior));
    });
  });

  group('UserProfileModel & Firestore Serialization', () {
    test('Correctly serializes and deserializes clinical intake to and from JSON', () {
      final dob = DateTime(1988, 3, 12);
      final profile = UserProfileModel(
        id: 'usr_test_999',
        email: 'alex@example.com',
        firstName: 'Alexander',
        lastName: 'Cross',
        dateOfBirth: dob,
        lifeStage: LifeStage.primeVitality,
        heightCm: 180.0,
        weightKg: 85.0,
        bloodType: 'A+',
        healthConditions: const ['Hypertension'],
        currentMedications: const ['Lisinopril 10mg'],
        exerciseFrequency: '4-5 days/week',
        typicalSleepHours: 8.0,
        alcoholIntake: 'Rarely',
        smokingStatus: 'Non-smoker',
        emergencyContactName: 'Jane Cross',
        emergencyContactPhone: '+1-555-0199',
        emergencyContactRelationship: 'Spouse',
        isOnboardingCompleted: true,
        createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 2),
      );

      final json = profile.toJson();
      expect(json['id'], equals('usr_test_999'));
      expect(json['email'], equals('alex@example.com'));
      expect(json['first_name'], equals('Alexander'));
      expect(json['health_conditions'], contains('Hypertension'));
      expect(json['current_medications'], contains('Lisinopril 10mg'));
      expect(json['typical_sleep_hours'], equals(8.0));
      expect(json['is_onboarding_completed'], isTrue);

      final reconstructed = UserProfileModel.fromJson(json);
      expect(reconstructed.id, equals(profile.id));
      expect(reconstructed.firstName, equals('Alexander'));
      expect(reconstructed.healthConditions, equals(['Hypertension']));
      expect(reconstructed.typicalSleepHours, equals(8.0));
      expect(reconstructed.isOnboardingCompleted, isTrue);
    });

    test('Serializes to Firestore map with Timestamps', () {
      final dob = DateTime(1985, 4, 10);
      final profile = UserProfileModel(
        id: 'usr_fs_123',
        email: 'david@example.com',
        firstName: 'David',
        lastName: 'Cole',
        dateOfBirth: dob,
        lifeStage: LifeStage.midlife,
        createdAt: DateTime(2026, 2, 1),
        updatedAt: DateTime(2026, 2, 1),
      );

      final firestoreMap = profile.toFirestore();
      expect(firestoreMap['id'], equals('usr_fs_123'));
      expect(firestoreMap['uid'], equals('usr_fs_123'));
      expect(firestoreMap['displayName'], equals('David Cole'));
      expect(firestoreMap['date_of_birth'], isA<Timestamp>());
      expect(firestoreMap['created_at'], isA<Timestamp>());
      expect(firestoreMap['updated_at'], isA<Timestamp>());
    });

    test('Supports uid and displayName aliases on UserProfile domain entity', () {
      final user = UserProfile(
        id: 'usr_alias_001',
        email: 'john@example.com',
        firstName: 'John',
        lastName: 'Doe',
        dateOfBirth: DateTime(1990, 1, 1),
        lifeStage: LifeStage.primeVitality,
        createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 1),
      );

      expect(user.uid, equals('usr_alias_001'));
      expect(user.displayName, equals('John Doe'));
      expect(user.fullName, equals('John Doe'));
    });
  });

  group('DashboardRepositoryImpl with Real User Profile', () {
    test('Loads real user details into dashboard instead of hardcoded mock data', () async {
      final realUser = UserProfile(
        id: 'usr_real_001',
        email: 'dr.johnson@example.com',
        firstName: 'Liam',
        lastName: 'Johnson',
        dateOfBirth: DateTime(1978, 8, 20), // 47 years old -> Midlife
        lifeStage: LifeStage.midlife,
        heightCm: 183.0,
        weightKg: 86.0,
        typicalSleepHours: 8.0,
        exerciseFrequency: '4-5 days/week',
        smokingStatus: 'Non-smoker',
        healthConditions: const ['None'],
        isOnboardingCompleted: true,
        createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 1),
      );

      final mockAuth = MockAuthRepository(initialUser: realUser, isOnboardingCompleted: true);
      final dashboardRepo = DashboardRepositoryImpl(authRepository: mockAuth);

      final result = await dashboardRepo.getDashboardData();
      expect(result.isRight(), isTrue);

      final data = result.getOrElse(() => throw Exception());
      // Confirms real user data is connected
      expect(data.userName, equals('Liam'));
      expect(data.lifeStage, equals(LifeStage.midlife));
      expect(data.healthScore.overallScore, greaterThan(85));
      expect(data.vitals.firstWhere((v) => v.keyName == 'sleep_duration').value, equals('8h'));
      expect(data.vitals.firstWhere((v) => v.keyName == 'body_weight').value, equals('86.0'));
    });

    test('watchDashboardData emits live updates when user profile changes', () async {
      final initialUser = UserProfile(
        id: 'usr_live_001',
        email: 'initial@example.com',
        firstName: 'Marcus',
        lastName: 'Vance',
        dateOfBirth: DateTime(1994, 5, 20),
        lifeStage: LifeStage.primeVitality,
        typicalSleepHours: 6.0,
        createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 1),
      );

      final mockAuth = MockAuthRepository(initialUser: initialUser);
      final dashboardRepo = DashboardRepositoryImpl(authRepository: mockAuth);

      final stream = dashboardRepo.watchDashboardData();
      final updates = <DashboardData>[];
      final subscription = stream.listen((data) => updates.add(data));

      await pumpEventQueue();
      expect(updates.isNotEmpty, isTrue);
      expect(updates.first.userName, equals('Marcus'));

      // Update user profile in auth repository (simulates Firestore update)
      final updatedUser = initialUser.copyWith(
        firstName: 'Alexander',
        typicalSleepHours: 8.5,
        updatedAt: DateTime.now(),
      );
      await mockAuth.completeOnboarding(updatedUser);
      await pumpEventQueue();

      expect(updates.length, greaterThanOrEqualTo(2));
      expect(updates.last.userName, equals('Alexander'));
      expect(
        updates.last.vitals.firstWhere((VitalMetricItem v) => v.keyName == 'sleep_duration').value,
        equals('8h 30m'),
      );

      await subscription.cancel();
      mockAuth.dispose();
    });
  });

  group('FirebaseService Graceful Handling', () {
    test('FirebaseService provides safe fallbacks when unconfigured', () {
      // In unit test environment without plist/json files
      expect(FirebaseService.isAvailable, isFalse);
      expect(FirebaseService.auth, isNull);
      expect(FirebaseService.firestore, isNull);
    });
  });

  group('OnboardingBloc Flow', () {
    test('Advances steps and calculates LifeStage on DateOfBirthChanged', () async {
      final authRepository = MockAuthRepository();
      final bloc = OnboardingBloc(authRepository: authRepository);

      expect(bloc.state.currentStep, equals(1));
      expect(bloc.state.totalSteps, equals(6));

      // Advance to step 2
      bloc.add(const NextStepPressed());
      await pumpEventQueue();
      expect(bloc.state.currentStep, equals(2));

      // Change DOB to someone born in 1980 (46 years old -> Midlife Health)
      final dob = DateTime(1980, 5, 15);
      bloc.add(DateOfBirthChanged(dob));
      await pumpEventQueue();

      expect(bloc.state.dateOfBirth, equals(dob));
      expect(bloc.state.calculatedLifeStage, equals(LifeStage.midlife));

      // Toggle health condition
      bloc.add(const HealthConditionToggled('Low Energy & Fatigue'));
      await pumpEventQueue();
      expect(bloc.state.healthConditions, contains('Low Energy & Fatigue'));

      // Toggle medication
      bloc.add(const MedicationToggled('Vitamin D3 + K2'));
      await pumpEventQueue();
      expect(bloc.state.currentMedications, contains('Vitamin D3 + K2'));

      await bloc.close();
    });
  });

  group('DashboardBloc Flow', () {
    test('Loads dashboard data successfully and toggles focus', () async {
      final dashboardRepo = MockDashboardRepository(delay: Duration.zero);
      final bloc = DashboardBloc(dashboardRepository: dashboardRepo);

      expect(bloc.state.status, equals(DashboardStatus.initial));

      bloc.add(const DashboardLoadRequested());
      await pumpEventQueue();

      expect(bloc.state.status, equals(DashboardStatus.loaded));
      expect(bloc.state.data, isNotNull);
      expect(bloc.state.data!.healthScore.overallScore, equals(88));
      expect(bloc.state.data!.vitals.length, equals(6));
      expect(bloc.state.data!.upcomingScreenings.length, equals(2));
      expect(bloc.state.data!.recentActivities.length, equals(3));
      expect(bloc.state.data!.todaysFocus.isCompleted, isFalse);

      // Toggle today's focus to completed
      bloc.add(const TodaysFocusActionToggled(focusId: 'focus_01', isCompleted: true));
      await pumpEventQueue();

      expect(bloc.state.data!.todaysFocus.isCompleted, isTrue);

      await bloc.close();
    });
  });

  group('HomeDashboardScreen Widget Test', () {
    testWidgets('Renders all clinical dashboard sections and metrics', (WidgetTester tester) async {
      final dashboardRepo = MockDashboardRepository(delay: Duration.zero);
      final bloc = DashboardBloc(dashboardRepository: dashboardRepo);

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<DashboardBloc>.value(
            value: bloc,
            child: const HomeDashboardScreen(),
          ),
        ),
      );

      // Pump frames for immediate mock data load
      await tester.pump();
      await tester.pump();

      // 1. Check Greeting & Life Stage
      expect(find.textContaining('Marcus'), findsWidgets);
      expect(find.textContaining('Prime Vitality'), findsOneWidget);

      // 2. Check Health Score Card
      expect(find.text('88'), findsOneWidget);
      expect(find.text('Optimal Vitality'), findsOneWidget);

      // 3. Check Today's Focus Card
      expect(find.text('CIRCADIAN ENDOCRINE PRIMING'), findsOneWidget);
      expect(find.text('Morning Sunlight & Electrolyte Protocol'), findsOneWidget);
      expect(find.text('Mark Completed'), findsOneWidget);

      // 4. Check Quick Vitals Section
      expect(find.text('Quick Vitals & Biomarkers'), findsOneWidget);
      expect(find.text('Blood Pressure'), findsOneWidget);
      expect(find.text('Total Testosterone'), findsOneWidget);
      expect(find.text('Resting Heart Rate'), findsOneWidget);

      // 5. Check Upcoming Screenings
      expect(find.text('Upcoming Screenings'), findsOneWidget);
      expect(find.text('Comprehensive Hormone & Lipid Panel'), findsOneWidget);
    });
  });

  group('App Smoke Test', () {
    testWidgets('MaleVitalityApp renders splash screen branding', (WidgetTester tester) async {
      await tester.pumpWidget(const MaleVitalityApp());

      // Check brand typography and medical compliance badge
      expect(find.text('MALEVITALITY'), findsOneWidget);
      expect(find.text('CLINICAL LONGEVITY & HEALTH OPTIMIZATION'), findsOneWidget);

      // Drain pending 3-second splash animation and navigation timer
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();
    });
  });

  group('Small Screen Responsiveness & Overflow Verification', () {
    testWidgets('HomeDashboardScreen renders without overflow on compact 320x568 screen', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final dashboardRepo = MockDashboardRepository(delay: Duration.zero);
      final bloc = DashboardBloc(dashboardRepository: dashboardRepo);

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<DashboardBloc>.value(
            value: bloc,
            child: const HomeDashboardScreen(),
          ),
        ),
      );

      await tester.pump();
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.text('88'), findsOneWidget);
    });

    testWidgets('LoginScreen renders without overflow on compact 320x568 screen', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final authRepo = MockAuthRepository();
      final authBloc = AuthBloc(authRepository: authRepo);

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>.value(
            value: authBloc,
            child: const LoginScreen(),
          ),
        ),
      );

      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.text('Member Sign In'), findsOneWidget);
    });

    testWidgets('SignUpScreen renders without overflow on compact 320x568 screen', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final authRepo = MockAuthRepository();
      final authBloc = AuthBloc(authRepository: authRepo);

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>.value(
            value: authBloc,
            child: const SignUpScreen(),
          ),
        ),
      );

      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.text('Create Health Profile'), findsOneWidget);
    });
  });
}
