import 'package:booking_hotel/business_logic/app_cubit/cubit.dart';
import 'package:booking_hotel/business_logic/app_cubit/states.dart';
import 'package:booking_hotel/constants/share/theme/themes.dart';
import 'package:booking_hotel/data/models/room_model.dart';
import 'package:booking_hotel/persentation/screens/booking_screen/booking_screen.dart';
import 'package:booking_hotel/persentation/widgets/main_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RoomsScreen extends StatefulWidget {
  final roomType;
  final branchName;
  const RoomsScreen(
      {Key? key, required this.roomType, required this.branchName})
      : super(key: key);

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  @override
  Widget build(BuildContext context) {
    AppCubit appCubit = AppCubit.get(context);

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
          '${widget.branchName} \"${widget.roomType}\"',
          style: Theme.of(context).textTheme.headline1!.copyWith(
                color: HotelThemes.primaryColor,
              ),
        ),
      ),
      body: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          appCubit.getBranchRooms(widget.branchName);
          List<dynamic> roomsType = [];
          roomsType = appCubit.branchRooms
              .where((element) => element.type == widget.roomType)
              .toList();
          return ListView.separated(
            itemBuilder: (context, index) =>
                tableRow(context, index, roomsType: roomsType[index]),
            separatorBuilder: (context, index) => Container(),
            itemCount: roomsType.length,
          );
        },
      ),
      bottomNavigationBar: Container(
          height: 60,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: mainButton(
                  context,
                  buttonColor: HotelThemes.primaryColor,
                  borderRadius: 0,
                  buttonHeight: 60,
                  text: 'Booking now',
                  press: () {
                    Get.to(
                      BookingScreen(
                        branchName: widget.branchName,
                        roomType: widget.roomType,
                        isBooking: true,
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: mainButton(
                  context,
                  buttonColor: Colors.white,
                  text: 'Add to booking list',
                  borderRadius: 0,
                  buttonHeight: 60,
                  boarderColor: HotelThemes.primaryColor,
                  textButtomColor: HotelThemes.primaryColor,
                  press: () {
                    Get.to(
                      BookingScreen(
                        branchName: widget.branchName,
                        roomType: widget.roomType,
                        isBooking: false,
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }

  Widget tableRow(context, index, {required roomsType}) {
    DateTime dateTime = DateTime.now();
    var appCubit = roomsType;
    return Container(
      padding: EdgeInsets.all(16.r),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Room ' + appCubit.roomNumber.toString(),
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              appCubit.booked == true ? "Booked" : "Available",
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              appCubit.type,
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              appCubit.booked
                  ? "${dateTime.day}/${dateTime.month}/${dateTime.year} ${appCubit.bookto}"
                  : "${appCubit.cost}LE",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: HotelThemes.primarySwatch.shade400,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
