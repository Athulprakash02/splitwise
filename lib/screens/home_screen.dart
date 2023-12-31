import 'package:flutter/material.dart';
import 'package:splitwise/functions/db_functions.dart';
import 'package:splitwise/functions/group_create.dart';
import 'package:splitwise/model/group_model.dart';
import 'package:splitwise/screens/expense_screen.dart';
import 'package:splitwise/screens/widgets/snackbar.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController _groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    fetchAllGroups();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: groupsNotifier,
        builder: (BuildContext ctx, List<GroupModel> groups, child) {
          return Padding(
            padding: EdgeInsets.all(size.width / 16),
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (ctx, index) {
                  final group = groups[index];

                  return Container(
                    width: size.width,
                    height: size.width*.22,
                    decoration: BoxDecoration(
                      color: Colors.white, // Container color
                      borderRadius:
                          BorderRadius.circular(8.0), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Shadow color
                          spreadRadius: 1, // Spread radius
                          blurRadius: 5, // Blur radius
                          offset: const Offset(0, 2), // Offset in the x, y direction
                        ),
                      ],
                    ),
                    child: Center(
                        child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return ExpenseScreen(group: group, index: index);
                          },
                        ));
                      },
                      leading: const CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            AssetImage('assets/images/icon image.png'),
                      ),
                      title: Text(
                        group.groupName,
                        style: const TextStyle(fontSize: 20),
                      ),
                      style: ListTileStyle.drawer,
                    )),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: groups.length),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                title: const Text('Create group'),
                content: TextField(
                  controller: _groupNameController,
                  decoration: InputDecoration(
                      hintText: 'Group name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 16),
                      )),
                  TextButton(
                      onPressed: () {
                        if (_groupNameController.text.isEmpty) {
                          showSnackBar(
                              context, Colors.red, "Group name can't be empty");
                        } else {
                          onCreateGroupClicked(
                              _groupNameController.text.trim(), context);
                          _groupNameController.clear();
                        }
                      },
                      child:
                          const Text('Create', style: TextStyle(fontSize: 16)))
                ],
              );
            },
          );
        },
        label: const Text(
          'create group',
          style: TextStyle(fontSize: 16),
        ),
        icon: const Icon(Icons.create),
      ),
    );
  }
}
