import 'package:booking_hotel/business_logic/app_cubit/cubit.dart';
import 'package:booking_hotel/business_logic/app_cubit/states.dart';
import 'package:booking_hotel/constants/share/theme/themes.dart';
import 'package:booking_hotel/constants/values.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BuildBanner extends StatefulWidget {
  const BuildBanner({Key? key}) : super(key: key);

  @override
  State<BuildBanner> createState() => _BuildBannerState();
}

class _BuildBannerState extends State<BuildBanner> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return Column(
          children: [
            CarouselSlider(
              items: AppCubit.get(context)
                  .banners
                  .map(
                    (e) => ClipRRect(
                      // borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        e,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  AppCubit.get(context).carouselWithSmooth(index);
                },
                height: displayHeight(context) / 4,
                viewportFraction: 1.0,
                enlargeCenterPage: true,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            AnimatedSmoothIndicator(
              activeIndex: AppCubit.get(context).activeIndex,
              count: AppCubit.get(context).banners.length,
              effect: SwapEffect(
                activeDotColor: HotelThemes.primaryColor,
                dotColor: HotelThemes.textColor,
                spacing: 5.0,
                dotWidth: 7.0,
                dotHeight: 7.0,
              ),
            ),
          ],
        );
      },
    );
  }
}
