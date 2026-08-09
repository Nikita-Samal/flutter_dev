import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:symptom_tracker/data/models/symptom.dart';

class SymptomsCubit extends Cubit<List<Symptom>> {
  SymptomsCubit()
      : super([
          Symptom(
            id: '1',
            name: 'Headache',
            recordedAt: DateTime.now().subtract(const Duration(hours: 3)),
            notes: 'Mild, after long screen time',
            isSevere: false,
          ),
          Symptom(
            id: '2',
            name: 'Fatigue',
            recordedAt: DateTime.now().subtract(const Duration(days: 1)),
            isSevere: true,
          ),
        ]);

  void addSymptom(Symptom symptom) {
    emit([symptom, ...state]);
  }

  void removeSymptom(String id) {
    emit(state.where((s) => s.id != id).toList());
  }
}
