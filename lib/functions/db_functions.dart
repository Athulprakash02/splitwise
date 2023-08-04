import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:splitwise/model/group_model.dart';
import 'package:splitwise/model/participant_model.dart';

ValueNotifier<List<GroupModel>> groupsNotifier = ValueNotifier([]);

Future<void> createGroup(GroupModel groupName) async {
  final create = await Hive.openBox<GroupModel>('groups');
  final group = await create.add(groupName);
  groupName.id = group;
  fetchAllGroups();
  groupsNotifier.value.add(groupName);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  groupsNotifier.notifyListeners();
}

Future<void> fetchAllGroups() async {
  final groups = await Hive.openBox<GroupModel>('groups');
  groupsNotifier.value.clear();
  groupsNotifier.value.addAll(groups.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  groupsNotifier.notifyListeners();
}

ValueNotifier<List<ParticipantModel>> participantNotifier = ValueNotifier([]);

Future<void> addParticipant(
    ParticipantModel participantName, String groupName) async {
  final create = await Hive.openBox<ParticipantModel>('participants');
  final group = await create.add(participantName);
  participantName.id = group;
  fetchParticipants(groupName);
  participantNotifier.value.add(participantName);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  participantNotifier.notifyListeners();
}

Future<void> fetchParticipants(String groupName) async {
  final participant = await Hive.openBox<ParticipantModel>('participants');

  participantNotifier.value.clear();

  final allParticipants = participant.values.toList();

  final selectedGroupParticipants = allParticipants
      .where((participant) => participant.groupName == groupName)
      .toList();

  participantNotifier.value.addAll(selectedGroupParticipants);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  participantNotifier.notifyListeners();
}
