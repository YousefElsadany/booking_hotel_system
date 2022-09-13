import 'package:booking_hotel/constants/share/theme/themes.dart';
import 'package:flutter/material.dart';

class BuildCountryCodeAndFlag extends StatelessWidget {
  const BuildCountryCodeAndFlag({
    Key? key,
  }) : super(key: key);

  String _generateCountryFlag() {
    String countryCode = 'eg';

    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

    return flag;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        height: double.maxFinite,
        // padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Center(
          child: Text(
            _generateCountryFlag() + ' +2 ',
            style: TextStyle(
              fontSize: 18,
              letterSpacing: 2.0,
              color: HotelThemes.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
