import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/todo_models.dart';

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]);

void addTodo(String title){
  final todo = Todo(
    name: title,
    createdAt: DateTime.now(),
  );
  emit([todo]);
}

}
