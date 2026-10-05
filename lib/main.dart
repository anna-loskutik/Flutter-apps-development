import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лаб №3',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
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
                'Калькулятор квадрата суммы',
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondScreen(
                          a: double.parse(_controllerA.text),
                          b: double.parse(_controllerB.text),
                        ),
                      ),
                    );
                  } else if (!_agreement) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Поставьте галочку согласия!')),
                    );
                  }
                },
                child: const Text('Рассчитать'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class SecondScreen extends StatelessWidget {
  final double a;
  final double b;

  const SecondScreen({super.key, required this.a, required this.b});

  @override
  Widget build(BuildContext context) {
    final double result = (a + b) * (a + b);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Результат'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Число a: $a',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Число b: $b',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              'Квадрат суммы: $result',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Назад'),
            ),
          ],
        ),
      ),
    );
  }
}