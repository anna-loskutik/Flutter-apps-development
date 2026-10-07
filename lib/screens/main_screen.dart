import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/main_screen_cubit.dart';
import 'cubit/main_screen_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controllerA = TextEditingController();
  final _controllerB = TextEditingController();
  bool _agreement = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Лоскутникова Анна Алексеевна'), 
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Text(
                'Калькулятор квадрата суммы (Cubit)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _controllerA,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Число a'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите число a';
                  if (double.tryParse(value) == null) return 'Введите корректное число';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _controllerB,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Число b'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите число b';
                  if (double.tryParse(value) == null) return 'Введите корректное число';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CheckboxListTile(
                title: const Text('Я согласен на обработку данных'),
                value: _agreement,
                onChanged: (bool? value) {
                  setState(() {
                    _agreement = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 20),
              
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _agreement) {
                    BlocProvider.of<MainScreenCubit>(context).calculate(
                      double.parse(_controllerA.text),
                      double.parse(_controllerB.text),
                    );
                  } else if (!_agreement) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Поставьте галочку согласия!')),
                    );
                  }
                },
                child: const Text('Рассчитать'),
              ),
              
              const SizedBox(height: 30),

              BlocBuilder<MainScreenCubit, MainScreenState>(
                builder: (context, state) {
                  if (state is MainScreenUpdateState) {
                    return Text(
                      'Результат: ${state.result}',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}