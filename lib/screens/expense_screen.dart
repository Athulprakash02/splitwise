import 'package:flutter/material.dart';
import 'package:splitwise/functions/add_participants.dart';
import 'package:splitwise/functions/db_functions.dart';
import 'package:splitwise/model/group_model.dart';
import 'package:splitwise/model/participant_model.dart';
import 'package:splitwise/screens/home_screen.dart';
import 'package:splitwise/screens/split_expense_screen.dart';
import 'package:splitwise/screens/widgets/snackbar.dart';

class ExpenseScreen extends StatelessWidget {
  ExpenseScreen({super.key, required this.group, required this.index});
  final GroupModel group;
  final int index;

  final TextEditingController _participantNameController =
      TextEditingController();

  final List<ParticipantModel> list = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    fetchParticipants(group.groupName);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                  (route) => false);
            },
            icon: const Icon(Icons.home)),
        title: const Text('Expenses'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: participantNotifier,
        builder:
            (BuildContext ctx, List<ParticipantModel> participants, child) {
          return Padding(
            padding: EdgeInsets.all(size.width / 16),
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final user = participants[index];
                  list.add(user);
                  return ListTile(
                      title: Text(
                        user.participantName,
                        style: const TextStyle(fontSize: 20),
                      ),
                      trailing: Text(
                        "₹${user.amount}",
                        style: const TextStyle(fontSize: 20),
                      ));
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: participants.length),
          );
        },
      ),
      persistentFooterButtons: [
        ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    title: const Text('Add participant'),
                    content: TextField(
                      controller: _participantNameController,
                      decoration: InputDecoration(
                          hintText: 'Participant name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('Cancel',
                              style: TextStyle(fontSize: 16))),
                      TextButton(
                          onPressed: () {
                            if (_participantNameController.text.isEmpty) {
                              showSnackBar(context, Colors.red,
                                  "Participant name can't be empty");
                            } else {
                              
                              onAddParticipantClicked(
                                  _participantNameController.text.trim(),
                                  group.groupName,
                                  context);
                                  _participantNameController.clear();
                            }
                          },
                          child:
                              const Text('Add', style: TextStyle(fontSize: 16)))
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Add participants')),
        ElevatedButton.icon(
            onPressed: () {
              
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SplitExpenseScreen(
                  group: group,
                  list: list,
                  index: index,
                ),
              ));

              // if(users)
            },
            icon: const Icon(Icons.attach_money_sharp),
            label: const Text('Split expense')),
      ],
    );
  }
}
