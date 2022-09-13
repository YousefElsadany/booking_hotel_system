import 'package:booking_hotel/business_logic/app_cubit/states.dart';
import 'package:booking_hotel/constants/share/theme/themes.dart';
import 'package:booking_hotel/persentation/screens/branches_screen/branches_screen.dart';
import 'package:booking_hotel/persentation/widgets/build_country_code_and_flag.dart';
import 'package:booking_hotel/persentation/widgets/build_large_container_field.dart';
import 'package:booking_hotel/persentation/widgets/build_text_form_field.dart';
import 'package:booking_hotel/persentation/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../business_logic/app_cubit/cubit.dart';

class PhoneAuth extends StatefulWidget {
  final backgrounColor;
  const PhoneAuth({
    Key? key,
    this.backgrounColor = Colors.white,
  }) : super(key: key);

  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            color: widget.backgrounColor,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: HotelThemes.primaryColor,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Enter your phone number.'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 20),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: BuildLargeContainerField(
                      height: 45,
                      borderColor: Colors.grey.shade400,
                      titleContainer: const BuildCountryCodeAndFlag(),
                      child: Expanded(
                        flex: 2,
                        child: BuildTextFormField(
                          lableText: '01X XXXX XXXX',
                          keyboardType: TextInputType.phone,
                          borderColor: Colors.white,
                          isPrefex: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number';
                            } else if (value.length < 10) {
                              return 'enter valid number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<AppCubit, AppStates>(
                    builder: (context, state) => mainButton(
                      context,
                      buttonWidth: double.infinity,
                      borderRadius: 8,
                      buttonColor: HotelThemes.primaryColor,
                      text: 'Login',
                      press: () {
                        if (formKey.currentState!.validate()) {
                          AppCubit.get(context)
                              .setCurrentGuest(phoneController.text);
                          AppCubit.get(context).changeLoggedIn();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BranchesScreen(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
