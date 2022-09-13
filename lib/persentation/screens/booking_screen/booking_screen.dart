import 'package:booking_hotel/business_logic/app_cubit/cubit.dart';
import 'package:booking_hotel/business_logic/app_cubit/states.dart';
import 'package:booking_hotel/constants/share/theme/themes.dart';
import 'package:booking_hotel/constants/values.dart';
import 'package:booking_hotel/data/models/room_model.dart';
import 'package:booking_hotel/persentation/widgets/build_text_form_field.dart';
import 'package:booking_hotel/persentation/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/models/booked_data.dart';
import 'booked_listview.dart';

class BookingScreen extends StatefulWidget {
  final String branchName;
  final String roomType;
  final isBooking;
  const BookingScreen(
      {Key? key,
      required this.branchName,
      required this.roomType,
      required this.isBooking})
      : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final nameController1 = TextEditingController();
  final nameController2 = TextEditingController();
  final nameController3 = TextEditingController();

  final formKey = GlobalKey<FormState>();
  List<Room> availbleRooms = [];
  int choosedRoomDbId = 0;
  Room? currentRoom;

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getBranchRooms(widget.branchName);
    filterAvailableRooms("single");
  }

  @override
  Widget build(BuildContext context) {
    final appCubit = AppCubit.get(context);
    appCubit.sumAllCost();
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: HotelThemes.primaryColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          widget.isBooking == true ? 'Booking' : 'Add to booking list',
          style: Theme.of(context).textTheme.headline1!.copyWith(
                color: HotelThemes.primaryColor,
              ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.isBooking == false
                      ? Column(
                          children: [
                            Text(
                              "Welcome to ${widget.branchName} branch",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            SizedBox(height: ScreenUtil().setHeight(20)),
                            Text(
                              "Room Type : ${widget.roomType}",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            if (appCubit.haveSale)
                              SizedBox(height: ScreenUtil().setHeight(20)),
                            if (appCubit.haveSale)
                              Text(
                                "\" You have a sale up to 95% \"",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(color: HotelThemes.primaryColor),
                              ),
                            SizedBox(height: ScreenUtil().setHeight(20)),
                            availbleRooms.length > 0
                                ? BlocBuilder<AppCubit, AppStates>(
                                    builder: (context, state) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Enter the names :-",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                        SizedBox(
                                            height: ScreenUtil().setHeight(20)),
                                        BuildTextFormField(
                                          keyboardType: TextInputType.name,
                                          controller: nameController1,
                                          lableText: 'First Name',
                                          pIcon: Icons.person,
                                        ),
                                        SizedBox(
                                            height: ScreenUtil().setHeight(15)),
                                        if (widget.roomType == "double")
                                          BuildTextFormField(
                                            keyboardType: TextInputType.name,
                                            controller: nameController2,
                                            lableText: 'Second Name',
                                            pIcon: Icons.person,
                                          ),
                                        if (widget.roomType == "suite")
                                          Column(
                                            children: [
                                              BuildTextFormField(
                                                keyboardType:
                                                    TextInputType.name,
                                                controller: nameController2,
                                                lableText: 'Second Name',
                                                pIcon: Icons.person,
                                              ),
                                              SizedBox(
                                                  height: ScreenUtil()
                                                      .setHeight(15)),
                                              BuildTextFormField(
                                                keyboardType:
                                                    TextInputType.name,
                                                controller: nameController3,
                                                lableText: 'Third Name',
                                                pIcon: Icons.person,
                                              ),
                                            ],
                                          ),
                                        SizedBox(
                                            height: ScreenUtil().setHeight(30)),
                                      ],
                                    ),
                                  )
                                : Text(
                                    "No rooms available in $widget.roomType",
                                  ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "booking summary",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Hotel branch: ${widget.branchName}",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                AppCubit.get(context).bookedRooms.length == 0
                                    ? Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        child: Center(
                                          child: Text(
                                            '\"Booking list is emty\"',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1!
                                                .copyWith(
                                                  color:
                                                      HotelThemes.primaryColor,
                                                ),
                                          ),
                                        ),
                                      )
                                    : BookedListView(),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(16.w),
                                  margin: EdgeInsets.all(10.w),
                                  color: HotelThemes.primarySwatch.shade400,
                                  child: Text(
                                    "Check cost: ${appCubit.allCost} L.E",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  mainButton(
                    context,
                    buttonColor: HotelThemes.primaryColor,
                    buttonWidth: 200.w,
                    text: widget.isBooking == true ? 'Book' : 'Add',
                    press: () async {
                      if (widget.isBooking == true) {
                        await bookPressed(appCubit);
                      } else {
                        await addPressed(appCubit);
                      }
                      // customSnackBar(context, "Please add at least 1 room");
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bookPressed(appCubit) async {
    if (appCubit.bookedRooms.length > 0) {
      // update room in data base
      appCubit.updateRoom(widget.branchName);
      //save this guest who booked in database (for sale)
      appCubit.saveNewGuestDatabase();
      //this guest have a sale
      appCubit.guestHaveSale();
      //filter available rooms again
      filterAvailableRooms(widget.roomType);
      //clear booking list
      appCubit.clearBookedList();
      //update current page data
      appCubit.getBranchRooms(widget.branchName);
      filterAvailableRooms(widget.roomType);
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "You must do at least one book",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      );
    }
  }

  addPressed(appCubit) {
    if (formKey.currentState!.validate()) {
      for (var room in availbleRooms) {
        if (room.dbId == choosedRoomDbId) {
          setState(() {
            currentRoom = room;
          });
        }
      }
      if (currentRoom != null) {
        List<String> currentGuests = [];
        if (nameController1.text.isNotEmpty)
          currentGuests.add(nameController1.text);
        if (nameController2.text.isNotEmpty)
          currentGuests.add(nameController2.text);
        if (nameController3.text.isNotEmpty)
          currentGuests.add(nameController3.text);
        appCubit.updateBookedList(BookedRoomData(
          guests: currentGuests,
          databaseId: choosedRoomDbId,
          cost:
              appCubit.haveSale ? currentRoom!.cost * 0.95 : currentRoom!.cost,
          roomType: widget.roomType,
          room: currentRoom!,
        ));
        setState(() {
          if (availbleRooms.length == 1)
            availbleRooms = [];
          else
            availbleRooms.remove(currentRoom);
          updateCurrentId();
          nameController1.text = "";
          nameController2.text = "";
          nameController3.text = "";
        });
      }
    }
  }

  filterAvailableRooms(String filterType) {
    setState(() {
      availbleRooms = [];
      for (var item in AppCubit.get(context).branchRooms) {
        if (item.type == filterType && item.booked == false) {
          availbleRooms.add(item);
          choosedRoomDbId = item.dbId;
        }
      }
    });
  }

  updateCurrentId() {
    for (var item in availbleRooms) {
      setState(() {
        choosedRoomDbId = item.dbId;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController1.dispose();
    nameController2.dispose();
    nameController3.dispose();
  }
}
