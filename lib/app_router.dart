import 'package:booking_hotel/constants/values.dart';
import 'package:booking_hotel/data/models/room_model.dart';
import 'package:booking_hotel/persentation/screens/branches_screen/branches_screen.dart';
import 'package:booking_hotel/persentation/screens/home_screen/home_screen.dart';
import 'package:booking_hotel/persentation/screens/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  AppRouter();

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case branchesScreen:
        return MaterialPageRoute(
          builder: (context) => BranchesScreen(),
        );
      case homeScreen:
        final branchName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => HomeScreen(
            branchName: branchName,
          ),
        );
      //
      //    case personalInfoScreen:
      //      // final userData = settings.arguments;
      //      return MaterialPageRoute(
      //        builder: (_) => BlocProvider<PhoneAuthCubit>.value(
      //          value: phoneAuthCubit!,
      //          child: const PersonalInfoScreen(),
      //        ),
      //      );
      //    case searchScreen:
      //      return MaterialPageRoute(
      //          builder: (_) => BlocProvider<SearchProductCubit>.value(
      //                value: searchProductCubit!,
      //                child: SearchScreen(),
      //              ));
      //    case policyScreen:
      //      final pageId = settings.arguments;
      //      return MaterialPageRoute(
      //        builder: (_) => PolicyScreen(pageId: pageId),
      //      );
      //
      //    case registrationScreen:
      //      final arg = settings.arguments as RegistrationScreen;
      //      return MaterialPageRoute(
      //        builder: (_) => RegistrationScreen(
      //          "",
      //          phoneNum: arg.phoneNum,
      //          userModel: arg.userModel,
      //          firebaseId: arg.firebaseId,
      //        ),
      //      );
      //    case loginScreen:
      //      return MaterialPageRoute(
      //        builder: (_) => BlocProvider<PhoneAuthCubit>.value(
      //          value: phoneAuthCubit!,
      //          child: LoginScreen(),
      //        ),
      //      );
      //    case otpScreen:
      //      final phoneNumber = settings.arguments;
      //      return MaterialPageRoute(
      //        builder: (_) => BlocProvider<RegisterCubit>.value(
      //          value: registerCubit!,
      //          child: BlocProvider<PhoneAuthCubit>.value(
      //            value: phoneAuthCubit!,
      //            child: OtpScreen(phoneNumber: phoneNumber),
      //          ),
      //        ),
      //      );
      //
      //
      //    case mapScreen:
      //      return MaterialPageRoute(
      //        builder: (_) => BlocProvider(
      //          create: (context) => MapsCubit(MapsRepo(MapServices())),
      //          child: const MapScreen(),
      //        ),
      //      );

    }
    return null;
  }
}
