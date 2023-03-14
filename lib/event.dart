import 'package:realm/realm.dart';

part 'event.g.dart';

/// Create an unique index on these properties : [groupId],[date],[slot]
@RealmModel()
class $SomeEvent {
  @MapTo('_id')
  @PrimaryKey()
  late String id;
  late String groupId;
  late DateTime date;
  late int slot;
  late String info;
}


// Schema in atlas 

// {
//   "title": "SomeEvent",
//   "bsonType": "object",
//   "required": [
//     "_id",
//     "groupId",
//     "date",
//     "slot",
//     "info"
//   ],
//   "properties": {
//     "_id": {
//       "bsonType": "string"
//     },
//     "groupId": {
//       "bsonType": "string"
//     },
//     "date": {
//       "bsonType": "date"
//     },
//     "slot": {
//       "bsonType": "long"
//     },
//     "info": {
//       "bsonType": "string"
//     }
//   }
// }