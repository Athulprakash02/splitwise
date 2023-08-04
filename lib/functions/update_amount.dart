
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splitwise/model/participant_model.dart';

Future<void> updateParticipantsAmounts(List<ParticipantModel> participants) async {
  final participantsBox = await Hive.openBox<ParticipantModel>('participants');
  for (var participant in participants) {
    final participantIndex = participantsBox.values.toList().indexWhere(
        (value) =>
            value.groupName == participant.groupName &&
            value.participantName == participant.participantName);

    if (participantIndex != -1) {
      await participantsBox.put(participantIndex, participant);
    } 
  }
}