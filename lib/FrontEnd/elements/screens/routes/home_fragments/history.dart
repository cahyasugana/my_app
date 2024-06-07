import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: historyList.length,
        itemBuilder: (BuildContext context, int index) {
          final history = historyList[index];
          return ListTile(
            title: Text('Pesanan #${history.id}'),
            subtitle: Text('Total: \$${history.total.toStringAsFixed(2)}'),
            onTap: () {
              _showOrderDetailDialog(context, history);
            },
          );
        },
      ),
    );
  }

  void _showOrderDetailDialog(BuildContext context, HistoryItem history) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detail Pesanan #${history.id}'),
          content: Text('Total: Rp. ${history.total.toStringAsFixed(2)}\nTanggal: ${history.date.toString()}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
}

// Contoh data riwayat belanja
class HistoryItem {
  final int id;
  final double total;
  final DateTime date;

  HistoryItem({
    required this.id,
    required this.total,
    required this.date,
  });
}

final List<HistoryItem> historyList = [
  HistoryItem(id: 1, total: 200000, date: DateTime.now().subtract(const Duration(days: 2))),
  HistoryItem(id: 2, total: 35000, date: DateTime.now().subtract(const Duration(days: 5))),
  HistoryItem(id: 3, total: 400000, date: DateTime.now().subtract(const Duration(days: 10))),
  HistoryItem(id: 4, total: 250000, date: DateTime.now().subtract(const Duration(days: 15))),
  HistoryItem(id: 5, total: 10000, date: DateTime.now().subtract(const Duration(days: 20))),
];
