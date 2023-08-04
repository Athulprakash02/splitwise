
import 'package:flutter/material.dart';
import 'package:splitwise/functions/db_functions.dart';
import 'package:splitwise/model/participant_model.dart';

Future<void> onAddParticipantClicked(String name,String groupName,BuildContext context) async {
  print('object');
  // final String groupName = name;
  final participant = ParticipantModel(groupName: groupName, participantName: name);

  addParticipant(participant,groupName);
    Navigator.of(context).pop();
}
