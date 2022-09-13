import 'package:booking_hotel/constants/share/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'phone_auth.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HotelThemes.backgroundColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HotelThemes.backgroundColor,
          statusBarIconBrightness: Brightness.dark,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
            )),
        iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
        backgroundColor: HotelThemes.backgroundColor,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: PhoneAuth(
          backgrounColor: HotelThemes.backgroundColor,
        ),
      ),
    );
  }
}
