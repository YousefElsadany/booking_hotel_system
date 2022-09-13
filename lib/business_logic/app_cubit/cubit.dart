import 'package:booking_hotel/business_logic/app_cubit/states.dart';
import 'package:booking_hotel/data/models/booked_data.dart';
import 'package:booking_hotel/data/models/room_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/share/helper/cash_helper.dart';
import '../../constants/share/helper/sql_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitalState());
  static AppCubit get(context) => BlocProvider.of(context);

  List<String> banners = [
    'assets/images/hotel.jpg',
    'assets/images/leaving.jpg',
    'assets/images/leaving2.jpg',
    'assets/images/pool.jpg',
    'assets/images/pool2.jpg',
    'assets/images/resturant.jpg',
  ];
  int activeIndex = 0;

  void carouselWithSmooth(index) {
    activeIndex = index;
    emit(ChangeCarouselAndSmothState());
  }

  SqlHelper sqlHelper = SqlHelper();
  bool isLoggedIn = false;
  List<Room> rooms = [];
  List guests = [];
  List<Room> branchRooms = [];
  List<BookedRoomData> bookedRooms = [];
  double allCost = 0;
  String currentGuest = "";
  var prefserences;
  bool haveSale = false;

  void createDB() async {
    emit(LoadingDatabaseState());
    prefserences = await SharedPreferences.getInstance();
    await sqlHelper.createDataBase();
    sqlHelper.getRoomsDatabase().then((value) {
      rooms = value;
      for (var r in rooms) {}
      emit(SuccessfulRoomDatabaseState());
    }).catchError((error) {
      emit(ErrorRoomDatabaseState(error.toString()));
    });
    sqlHelper.getGuestDatabase().then((value) {
      guests = value;
      for (String g in guests) {
        if (currentGuest == g) {
          prefserences.setBool("currentGuestSale", true);
          guestHaveSale();
        }
      }
      emit(SuccessfulGuestsDatabaseState());
    }).catchError((error) {
      emit(ErrorGuestsDatabaseState(error.toString()));
    });
  }

  //save guest who booked only in the datatbase
  saveNewGuestDatabase() {
    sqlHelper.insertNewGuest(currentGuest).then((value) {
      rooms = value;
      emit(SuccessfulInsertUserState());
    }).catchError((error) {
      emit(ErrorInsertUserState(error.toString()));
    });
  }

  //change flag
  changeLoggedIn() {
    isLoggedIn = !isLoggedIn;
    emit(IsLoggedChangedState());
  }

  //keep guest logged in also if closed the app
  getCurrentGuest() async {
    prefserences = await SharedPreferences.getInstance();
    if (prefserences.getString('guest') != null) {
      currentGuest = prefserences.getString('guest');
      changeLoggedIn();
      emit(ChangeGuestState());
    }
    if (prefserences.getBool('currentGuestSale') != null) {
      guestHaveSale();
    }
    print(
        "name: $currentGuest, isLoggedIn: $isLoggedIn, have a sale: $haveSale");
  }

  setCurrentGuest(String guest) {
    prefserences.setString('guest', "$guest");
    currentGuest = guest;
    emit(ChangeGuestState());
  }

  getBranchRooms(String branchName) {
    branchRooms = [];
    for (Room room in rooms) {
      if (room.branch == branchName) {
        branchRooms.add(room);
      }
    }
    emit(GetBranchRoomsState());
  }

  //this guest have a sale
  guestHaveSale() {
    haveSale = true;
    emit(HaveSaleState());
  }

  //update statues of the task
  void updateRoom(String branchName) async {
    for (BookedRoomData r in bookedRooms) {
      String allGuests = r.guests[0];
      for (int i = 1; i < r.guests.length; i++) {
        allGuests += ",${r.guests[i]}";
      }
      await sqlHelper.updateRoom(r.databaseId, true, allGuests);
      allGuests = "";
    }
    sqlHelper.getRoomsDatabase().then((value) {
      rooms = value;
      getBranchRooms(branchName);
      emit(SuccessfulRoomDatabaseState());
    }).catchError((error) {
      emit(ErrorRoomDatabaseState(error.toString()));
    });
  }

  //update the list of booked rooms
  updateBookedList(BookedRoomData room) {
    bookedRooms.add(room);
    emit(UpdateBookedListState());
  }

  clearBookedList() {
    bookedRooms = [];
    emit(ClearBookedListState());
  }

  sumAllCost() {
    allCost = 0;
    for (BookedRoomData i in bookedRooms) {
      allCost += i.cost;
    }
    emit(UpdateAllCost());
  }
}
