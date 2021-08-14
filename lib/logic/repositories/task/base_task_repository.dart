import 'package:aking/logic/models/task.dart';

abstract class BaseTaskRepository {
  Stream<List<Task>> getAllTasks(String uid);
}
