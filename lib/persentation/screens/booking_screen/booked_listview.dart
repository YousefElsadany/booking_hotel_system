import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../business_logic/app_cubit/cubit.dart';
import '../../../business_logic/app_cubit/states.dart';

class BookedListView extends StatelessWidget {
  const BookedListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          final bookedRooms = AppCubit.get(context).bookedRooms;
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(12.0),
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => SizedBox(
                height: 20.0,
              ),
              itemCount: bookedRooms.length,
              itemBuilder: (context, index) => Container(
                height: MediaQuery.of(context).size.height * 0.15,
                padding: EdgeInsets.all(12.w),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 8.0)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Room type: ${bookedRooms[index].roomType}",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      "Room Cost: ${bookedRooms[index].cost} L.E",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: bookedRooms[index].guests.length,
                        itemBuilder: (context, inx) => Center(
                          child: Text(
                            bookedRooms[index].guests[inx],
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ), //
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
