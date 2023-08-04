import 'package:flutter/material.dart';
import 'package:splitwise/functions/db_functions.dart';
import 'package:splitwise/functions/update_amount.dart';
import 'package:splitwise/model/group_model.dart';
import 'package:splitwise/model/participant_model.dart';
import 'package:splitwise/screens/expense_screen.dart';
import 'package:splitwise/screens/home_screen.dart';
import 'package:splitwise/screens/widgets/snackbar.dart';

class SplitExpenseScreen extends StatefulWidget {
  const SplitExpenseScreen(
      {super.key,
      required this.group,
      required this.list,
      required this.index});
  final GroupModel group;
  final List<ParticipantModel> list;
  final int index;

  @override
  State<SplitExpenseScreen> createState() => _SplitExpenseScreenState();
}

class _SplitExpenseScreenState extends State<SplitExpenseScreen> {
  final TextEditingController _amountController = TextEditingController();
  final List<TextEditingController> _percentageControllers = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.list.length; i++) {
      _percentageControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var controller in _percentageControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Split expense'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width / 16),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Enter amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(vertical: size.width / 10),
              child: ValueListenableBuilder(
                valueListenable: participantNotifier,
                builder: (BuildContext ctx, List<ParticipantModel> participants,
                    child) {
                  return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final user = participants[index];
                        return Container(
                          width: size.width,
                          height: size.width * .22,
                          decoration: BoxDecoration(
                            color: Colors.white, // Container color
                            borderRadius:
                                BorderRadius.circular(8.0), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Shadow color
                                spreadRadius: 1, // Spread radius
                                blurRadius: 5, // Blur radius
                                offset: const Offset(
                                    0, 2), // Offset in the x, y direction
                              ),
                            ],
                          ),
                          child: Center(
                              child: ListTile(
                                  title: Text(
                                    user.participantName,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  trailing: SizedBox(
                                    width: size.width * .15,
                                    height: size.width * .2,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller:
                                          _percentageControllers[index],
                                      decoration: InputDecoration(
                                          hintText: '%',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                    ),
                                  ))),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: participants.length);
                },
              ),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            num total = splitExpense();
            if (total == 100) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ExpenseScreen(
                  group: widget.group,
                  index: widget.index,
                ),
              ));
            } else {
              showSnackBar(
                  context, Colors.red, "Total percentage should be 100.");
            }
          },
          label: const Text('Split expense')),
    );
  }

  num splitExpense() {
    double totalAmount = double.tryParse(_amountController.text) ?? 0;
    double totalPercentage = 0;

    for (var controller in _percentageControllers) {
      if (controller.text.isNotEmpty) {
        totalPercentage += double.tryParse(controller.text) ?? 0;
      }
    }

    if (totalPercentage == 100) {
      for (var i = 0; i < widget.list.length; i++) {
        double percentage =
            double.tryParse(_percentageControllers[i].text) ?? 0;
        double share = (totalAmount * percentage) / 100;
        widget.list[i].amount = share;
      }

      updateParticipantsAmounts(widget.list);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
          (route) => false);

      _amountController.clear();
      for (var controller in _percentageControllers) {
        controller.clear();
      }
      return totalPercentage;
    } else {
      showSnackBar(context, Colors.red, "Total percentage should be 100.");
    }
    return 0;
  }
}
