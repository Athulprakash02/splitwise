import 'package:flutter/material.dart';
import 'package:splitwise/functions/db_functions.dart';
import 'package:splitwise/model/group_model.dart';
import 'package:splitwise/model/participant_model.dart';

Future<void> onCreateGroupClicked(String name,BuildContext context) async {
  print('object');
  final String groupName = name;
  final List<ParticipantModel> participants = [];

  final group = GroupModel(
    groupName: groupName,
    participants: participants,
  );

  createGroup(group);
  Navigator.of(context).pop();
}
