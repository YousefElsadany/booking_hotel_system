import 'package:booking_hotel/business_logic/app_cubit/cubit.dart';
import 'package:booking_hotel/business_logic/app_cubit/states.dart';
import 'package:booking_hotel/constants/share/theme/themes.dart';
import 'package:booking_hotel/data/models/room_model.dart';
import 'package:booking_hotel/persentation/screens/booking_screen/booking_screen.dart';
import 'package:booking_hotel/persentation/screens/home_screen/build_banner.dart';
import 'package:booking_hotel/persentation/screens/rooms_screen/rooms_screen.dart';
import 'package:booking_hotel/persentation/widgets/main_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  final String branchName;
  const HomeScreen({Key? key, required this.branchName}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello!",
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Welcome in \"${widget.branchName}\" branch",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      if (AppCubit.get(context).haveSale)
                        Text("You have a sale up to 95%"),
                    ],
                  ),
                  ScreenUtilInit(
                    minTextAdapt: true,
                    splitScreenMode: true,
                    builder: (context, child) => Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.to(
                                  BookingScreen(
                                    branchName: widget.branchName,
                                    roomType: 'single',
                                    isBooking: true,
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.folder,
                                color: HotelThemes.primarySwatch.shade400,
                                size: ScreenUtil().setSp(30),
                              ),
                            ),
                            Text('Booking List'),
                          ],
                        ),
                        CircleAvatar(
                          radius: ScreenUtil().setSp(10),
                          backgroundColor: Colors.grey,
                          child: BlocBuilder<AppCubit, AppStates>(
                            builder: (context, state) => Text(
                              AppCubit.get(context)
                                  .bookedRooms
                                  .length
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const BuildBanner(),
            const SizedBox(
              height: 40.0,
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: mainButton(
                      context,
                      buttonColor: HotelThemes.primaryColor,
                      text: 'Single',
                      buttonWidth: 200.w,
                      press: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => RoomsScreen(
                              branchName: widget.branchName,
                              roomType: 'single',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: mainButton(
                      context,
                      buttonColor: HotelThemes.primaryColor,
                      text: 'Double',
                      buttonWidth: 200.w,
                      press: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => RoomsScreen(
                              branchName: widget.branchName,
                              roomType: 'double',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: mainButton(
                      context,
                      buttonColor: HotelThemes.primaryColor,
                      text: 'Suite',
                      buttonWidth: 200.w,
                      press: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => RoomsScreen(
                              branchName: widget.branchName,
                              roomType: 'suite',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
