# MaleVitality 🩺⚡

> Production-ready Flutter foundation for an enterprise men's health, longevity, and clinical wellness application.

---

## 🏗 Architecture & Layout

This project follows Clean Architecture principles with modular domain separations:

```text
lib/
├── core/                       # App-wide infrastructure & utilities
│   ├── theme/                  # Design tokens, typography, spatial scale, ThemeData
│   │   ├── app_theme.dart
│   │   ├── app_text_styles.dart
│   │   └── app_spacing.dart
│   ├── constants/              # Static constants, URLs, and clinical standards
│   │   ├── app_urls.dart
│   │   ├── app_constants.dart
│   │   └── life_stage_constants.dart
│   ├── routing/                # Centralized GoRouter setup
│   │   └── app_router.dart
│   ├── utils/                  # Input & biomarker validators, date tools, formatters
│   │   ├── validators.dart
│   │   ├── date_utils.dart
│   │   └── formatters.dart
│   ├── network/                # Dio client with interceptors and error translation
│   │   └── api_client.dart
│   └── error/                  # Failure abstractions for domain/data layers
│       └── failures.dart
│
├── common/                     # Shared UI components & utilities
│   ├── colors/                 # Deep Navy Blue, Restorative Teal & clinical palettes
│   │   └── app_colors.dart
│   ├── widgets/                # Standardized reusable design system widgets
│   │   ├── buttons/            # AppButton (primary, secondary, outline, ghost, danger)
│   │   ├── cards/              # AppCard (with biomarker indicator strips)
│   │   └── inputs/             # AppTextField (clinical forms with validation)
│   └── extensions/             # BuildContext convenience helpers
│       └── context_extensions.dart
│
├── domain/                     # Pure business logic layer (independent of Flutter)
│   ├── entities/               # Core business models (e.g. UserProfile)
│   ├── repositories/           # Repository interfaces
│   └── usecases/               # Clean architecture use case abstractions
│
├── data/                       # Data access & persistence layer
│   ├── models/                 # DTOs with JSON serialization
│   ├── repositories/           # Implementations of domain repository contracts
│   ├── datasources/            # Remote (REST/GraphQL) & Local (Cache/SecureStorage)
│   │   ├── remote/
│   │   └── local/
│   └── services/               # Device & infrastructure services
│
├── features/                   # Functional domain verticals
│   ├── auth/                   # Authentication & biometric login
│   ├── onboarding/             # Clinical intake & health goal survey
│   ├── dashboard/              # Central vitals & daily vitality score
│   ├── tracking/               # Daily biomarker logging (BP, HR, HRV)
│   ├── screenings/             # Lab test orders & PSA / endocrine panels
│   ├── mental_wellness/        # Stress, mood, cortisol & meditation
│   ├── fitness/                # Strength protocols & cardiovascular regimens
│   ├── nutrition/              # Protein optimization, fasting & micronutrients
│   ├── sleep/                  # Sleep staging, circadian rhythm & recovery
│   ├── sexual_health/          # Andrology, fertility & vitality protocols
│   ├── medications/            # TRT tracking, supplements & prescriptions
│   ├── telehealth/             # Video consultations with clinicians
│   └── profile/                # User settings, privacy & HIPAA data exports
│
└── main.dart                   # Application entrypoint with MaterialApp.router
```

---

## 🎨 Design System

- **Primary Color:** Deep Navy Blue (`#1A3A5C`) — Trust, clinical authority, precision.
- **Secondary Color:** Restorative Teal (`#0D9488`) — Vitality, healing, recovery.
- **Background Color:** Slate 50 (`#F8FAFC`) — Crisp, medical clarity.
- **Typography:** Inter hierarchy with high-readability weights.
- **Spacing Scale:** 8-point spatial system (`4, 8, 16, 24, 32, 48`).
- **Corner Radii:** Standardized curved geometry (`4, 8, 12, 16, 24, 999`).

---

## 🚀 Getting Started

### 1. Set Workspace
Open `/Users/niks/Documents/Development/Projects-ZML/male_vitality` in your IDE (VS Code or Android Studio).

### 2. Fetch Dependencies
```bash
cd /Users/niks/Documents/Development/Projects-ZML/male_vitality
flutter pub get
```

### 3. Run Application
```bash
flutter run
```
