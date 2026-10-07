abstract class MainScreenState {}

class MainScreenInitial extends MainScreenState {}

class MainScreenUpdateState extends MainScreenState {
  final double result;
  MainScreenUpdateState({required this.result});
}