import 'package:flutter/material.dart';
import '../db/db_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final data = await DBProvider.db.getAllCalculations();
    setState(() {
      _history = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('История расчетов'), backgroundColor: Colors.blue),
      body: _history.isEmpty
          ? const Center(child: Text('История пуста'))
          : ListView.builder(
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final item = _history[index];
                return ListTile(
                  title: Text('(${item['a']} + ${item['b']})² = ${item['result']}'),
                  subtitle: Text('Запись №${item['id']}'),
                );
              },
            ),
    );
  }
}