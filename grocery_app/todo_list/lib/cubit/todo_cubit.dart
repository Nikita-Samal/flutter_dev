import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/todo_models.dart';

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]);
}
