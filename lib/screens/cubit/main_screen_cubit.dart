import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(MainScreenInitial());

  void calculate(double a, double b) {
    double result = (a + b) * (a + b);
    emit(MainScreenUpdateState(result: result));
  }
}