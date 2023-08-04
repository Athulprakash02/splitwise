import 'package:flutter/material.dart';
import 'package:splitwise/functions/db_functions.dart';
import 'package:splitwise/model/group_model.dart';
import 'package:splitwise/model/participant_model.dart';

class SplitExpenseScreen extends StatefulWidget {
  SplitExpenseScreen({super.key, required this.group, required this.list});
  final GroupModel group;
  final List<ParticipantModel> list;

  @override
  State<SplitExpenseScreen> createState() => _SplitExpenseScreenState();
}

class _SplitExpenseScreenState extends State<SplitExpenseScreen> {
  final TextEditingController _amountController = TextEditingController();
  final List<TextEditingController> _percentageControllers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var i = 0; i < widget.list.length; i++) {
      _percentageControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose

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
        title: Text('Split expense'),
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
                  return Padding(
                    padding: EdgeInsets.all(size.width / 16),
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final user = participants[index];
                          return ListTile(
                              title: Text(
                                user.participantName,
                                style: const TextStyle(fontSize: 18),
                              ),
                              trailing: SizedBox(
                                width: size.width * .15,
                                height: size.width * .2,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: _percentageControllers[index],
                                  decoration: InputDecoration(
                                      hintText: '%',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                ),
                              ));
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: participants.length),
                  );
                },
              ),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _splitExpense();
          }, label: Text('Split expense')),
    );
  }

  void _splitExpense(){
    num totalPercentage = 0;
    for(var controller in _percentageControllers){
      if(controller.text.isNotEmpty){
        totalPercentage += num.tryParse(controller.text) ?? 0;
      }
      print(totalPercentage);
    }
  }
}
