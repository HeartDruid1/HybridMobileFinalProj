import 'package:Phonegazer/databaseHelper.dart';

class Pedal{
  int id;
  String pedalName;
  String effectType;
  String parameters;
  String notes;

Pedal(this.id, this.pedalName, this.effectType, this.parameters, this.notes);
Pedal.fromMap(Map<String, dynamic> map){
  id = map['id'];
  pedalName = map['pedalName'];
  effectType = map['effectType'];
  parameters = map['parameters'];
  notes = map['notes'];
}

Map<String, dynamic> toMap() {
  return {
    DataBaseHelper.colId: id,
    DataBaseHelper.colPedalName: pedalName,
    DataBaseHelper.colEffectType: effectType,
    DataBaseHelper.colParameters: parameters,
    DataBaseHelper.colNotes: notes,
  };
}

}