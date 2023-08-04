import 'package:flutter/material.dart';
import 'package:splitwise/functions/add_participants.dart';
import 'package:splitwise/functions/db_functions.dart';
import 'package:splitwise/model/group_model.dart';
import 'package:splitwise/model/participant_model.dart';
import 'package:splitwise/screens/widgets/snackbar.dart';

class ExpenseScreen extends StatelessWidget {
  ExpenseScreen({super.key, required this.group, required this.index});
  final GroupModel group;
  final int index;

  TextEditingController _participantNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    fetchParticipants(group.groupName);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: participantNotifier,
        builder:
            (BuildContext ctx, List<ParticipantModel> participants, child) {
          return Padding(
            padding:  EdgeInsets.all(size.width/16),
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final user = participants[index];
                  return ListTile(title: Text(user.participantName,style: TextStyle(fontSize: 18),),
                  trailing: Text("₹"+ user.amount.toString(),style: TextStyle(fontSize: 18),));
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
                    title: const Text('Create group'),
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
                          child: const Text('Cancel')),
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
                              // onCreateGroupClicked(
                              //     _groupNameController.text.trim(), context);
                            }
                          },
                          child: const Text('Add'))
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Add participants')),
        ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.attach_money_sharp),
            label: const Text('Split expense')),
      ],
    );
  }
}
