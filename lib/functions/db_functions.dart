import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:splitwise/model/group_model.dart';

ValueNotifier<List<GroupModel>> groupsNotifier = ValueNotifier([]);

Future<void> createGroup(GroupModel groupName) async{
  final create = await Hive.openBox<GroupModel>('groups');
  final group = await create.add(groupName);
  groupName.id = group;
  fetchAllGroups();
  groupsNotifier.value.add(groupName);
  groupsNotifier.notifyListeners();


}

Future<void> fetchAllGroups() async{
  final groups = await Hive.openBox<GroupModel>('groups');

  groupsNotifier.value.clear();
  groupsNotifier.value.addAll(groups.values);
  groupsNotifier.notifyListeners();
}