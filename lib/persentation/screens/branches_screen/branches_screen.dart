import 'package:booking_hotel/constants/share/theme/themes.dart';
import 'package:booking_hotel/constants/values.dart';
import 'package:booking_hotel/persentation/screens/login_auth/phone_auth_screen.dart';
import 'package:booking_hotel/persentation/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../business_logic/app_cubit/cubit.dart';

class BranchesScreen extends StatefulWidget {
  const BranchesScreen({Key? key}) : super(key: key);

  @override
  State<BranchesScreen> createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: Text(
          'Branches',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          AppCubit.get(context).isLoggedIn
              ? TextButton(
                  onPressed: () async {
                    await Get.bottomSheet(
                      Container(
                        height: 150,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Logout',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                    color: HotelThemes.primaryColor,
                                  ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Are you sure ?",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                mainButton(
                                  context,
                                  buttonColor: HotelThemes.primaryColor,
                                  text: 'YES',
                                  press: () {
                                    AppCubit.get(context).changeLoggedIn();
                                    Navigator.of(context).pop();
                                  },
                                  buttonHeight: 35,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                mainButton(
                                  context,
                                  buttonColor: Colors.white,
                                  textButtomColor: HotelThemes.primaryColor,
                                  text: 'Cancel',
                                  boarderColor: HotelThemes.primaryColor,
                                  press: () {
                                    Navigator.of(context).pop();
                                  },
                                  buttonHeight: 35,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.logout,
                        color: HotelThemes.primaryColor,
                      ),
                      Text('Logout')
                    ],
                  ),
                )
              : TextButton(
                  onPressed: () {
                    Get.to(PhoneAuthScreen());
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.login,
                        color: HotelThemes.primaryColor,
                      ),
                      Text('Login')
                    ],
                  ),
                ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            branchesBar(
              context,
              imagePath: 'assets/images/cairo.jpg',
              text: ' Cairo ',
              onTap: () {
                if (AppCubit.get(context).isLoggedIn) {
                  Navigator.of(context)
                      .pushNamed(homeScreen, arguments: 'Cairo');
                } else {
                  bottomSheetMessage(
                    context,
                    title: 'Cairo',
                  );
                }
              },
            ),
            Spacer(),
            branchesBar(
              context,
              imagePath: 'assets/images/suez.jpg',
              text: ' Suez ',
              onTap: () {
                if (AppCubit.get(context).isLoggedIn) {
                  Navigator.of(context)
                      .pushNamed(homeScreen, arguments: 'Suez');
                } else {
                  bottomSheetMessage(
                    context,
                    title: 'Suez',
                  );
                }
              },
            ),
            Spacer(),
            branchesBar(
              context,
              imagePath: 'assets/images/alex.jpg',
              text: ' Alexandria ',
              onTap: () {
                if (AppCubit.get(context).isLoggedIn) {
                  Navigator.of(context)
                      .pushNamed(homeScreen, arguments: 'Alexandria');
                } else {
                  bottomSheetMessage(
                    context,
                    title: 'Alexandria',
                  );
                }
              },
            ),
            Spacer(),
            branchesBar(
              context,
              imagePath: 'assets/images/aswan.jpg',
              text: 'Aswan',
              onTap: () {
                if (AppCubit.get(context).isLoggedIn) {
                  Navigator.of(context)
                      .pushNamed(homeScreen, arguments: 'Aswan');
                } else {
                  bottomSheetMessage(
                    context,
                    title: 'Aswan',
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

bottomSheetMessage(context, {required title}) async {
  await Get.bottomSheet(
    Container(
      height: 150,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: HotelThemes.primaryColor,
                ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "You must login to do booking",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: 20,
          ),
          mainButton(
            context,
            buttonColor: HotelThemes.primaryColor,
            text: 'OK'.tr,
            press: () {
              Navigator.of(context).pop();
            },
            buttonHeight: 35,
          ),
        ],
      ),
    ),
  );
}

Widget branchesBar(context,
        {required imagePath, required text, required onTap}) =>
    Expanded(
      flex: 3,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 130,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
              opacity: 0.9,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
              ),
              BoxShadow(
                color: Colors.black,
                spreadRadius: -12.0,
                blurRadius: 12.0,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(30),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
