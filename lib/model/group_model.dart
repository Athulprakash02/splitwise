import 'package:hive/hive.dart';
import 'package:splitwise/model/participant_model.dart';
part 'group_model.g.dart';

@HiveType(typeId: 1)
class GroupModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String groupName;

  @HiveField(2)
  final List<ParticipantModel> participants;

  GroupModel({
    required this.groupName,
    required this.participants,
  });
}
