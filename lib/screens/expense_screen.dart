import 'package:flutter/material.dart';
import 'package:splitwise/model/group_model.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key, required this.group, required this.index});
  final GroupModel group;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
        centerTitle: true,
      ),
    );
  }
}