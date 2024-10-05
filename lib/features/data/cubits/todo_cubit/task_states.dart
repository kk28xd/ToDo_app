abstract class TaskStates {}

class TaskInitial extends TaskStates {}
class TaskLoading extends TaskStates {}
class TaskSuccess extends TaskStates {}
class TaskFailure extends TaskStates {
  final String errorMessage;

  TaskFailure({required this.errorMessage});
}


class AddTaskSuccess extends TaskStates {}
class AddTaskLoading extends TaskStates {}
class AddTaskFailure extends TaskStates {
  final String errorMessage;

  AddTaskFailure({required this.errorMessage});
}


class UpdateTaskLoading extends TaskStates {}
class UpdateTaskSuccess extends TaskStates {}
class UpdateTaskFailure extends TaskStates {
  final String errorMessage;

  UpdateTaskFailure({required this.errorMessage});
}
