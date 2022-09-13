import 'package:booking_hotel/data/models/room_model.dart';

class BookedRoomData {
  String roomType;
  List<String> guests;
  double cost;
  int databaseId;
  Room room;
  BookedRoomData({
    required this.roomType,
    required this.guests,
    required this.cost,
    required this.databaseId,
    required this.room,
  });
}
