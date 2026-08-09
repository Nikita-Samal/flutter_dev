import 'package:flutter_test/flutter_test.dart';
import 'package:symptom_tracker/data/models/symptom.dart';

void main() {
  group('Symptom Freezed model', () {
    test('creates correctly and supports copyWith', () {
      final now = DateTime(2026, 8, 9, 15, 30);
      final s = Symptom(
        id: 'test-1',
        name: 'Headache',
        recordedAt: now,
        notes: 'After coffee',
        isSevere: false,
      );

      expect(s.id, 'test-1');
      expect(s.name, 'Headache');
      expect(s.notes, 'After coffee');
      expect(s.isSevere, false);

      final updated = s.copyWith(isSevere: true, notes: null);
      expect(updated.isSevere, true);
      expect(updated.notes, isNull);
      expect(updated.name, 'Headache');
    });

    test('toJson / fromJson round-trip', () {
      final original = Symptom(
        id: 'round-1',
        name: 'Nausea',
        recordedAt: DateTime.utc(2026, 8, 9, 10, 0),
        notes: 'Mild',
        isSevere: true,
      );

      final json = original.toJson();
      final restored = Symptom.fromJson(json);

      expect(restored, equals(original));
      expect(restored.notes, 'Mild');
      expect(restored.isSevere, true);
    });

    test('optional notes can be null', () {
      final s = Symptom(
        id: 'null-notes',
        name: 'Fatigue',
        recordedAt: DateTime.now(),
      );

      expect(s.notes, isNull);
      expect(s.isSevere, false);
    });
  });
}
