import 'package:hive/hive.dart';

part 'participant_model.g.dart';

@HiveType(typeId: 2)
class ParticipantModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String groupName;

  @HiveField(2)
  final String participantName;

  @HiveField(3)
   num amount;

  ParticipantModel(
   {required this.groupName,
   required this.participantName,this.amount=0
   }
  );
}
