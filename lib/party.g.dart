// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Party _$PartyFromJson(Map<String, dynamic> json) {
  return Party(
    partyName: json['partyName'] as String,
    pastWinners: (json['winners'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$PartyToJson(Party instance) => <String, dynamic> {
  'partyName': instance.partyName,
  'winners': instance.pastWinners,
};
