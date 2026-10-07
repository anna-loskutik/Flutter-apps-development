import 'package:flutter_bloc/flutter_bloc.dart';
import '../../db/db_provider.dart';
import 'main_screen_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(MainScreenInitial());

  Future<void> calculate(double a, double b) async {
    double result = (a + b) * (a + b);

    await DBProvider.db.addCalculation(a, b, result);

    final prefs = await SharedPreferences.getInstance();
    int count = prefs.getInt('calc_count') ?? 0;
    await prefs.setInt('calc_count', count + 1);

    emit(MainScreenUpdateState(result: result));
  }
}