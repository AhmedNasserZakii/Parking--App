import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/all_user_details.dart';
import '../models/const.dart';

class CardInfo extends StatelessWidget {
  const CardInfo({super.key});

  @override
  Widget build(BuildContext context) {
    const bookDetails = BookDetails(
      carType: 'BMW X6',
      parkingSlot: 'A08',
      timeDuration: Duration(hours: 4),
      pricePerHour: 18,
    );
    return SizedBox(
      width: 400.w,
      height: 180.h,
      child: Card(
        color: kMainColor,
        elevation: 4,
        margin: EdgeInsets.all(16.h),
        child: Padding(
          padding: EdgeInsets.all(12.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Car Type: ${bookDetails.carType}',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 70),
                Text(
                  'Parking Slot: ${bookDetails.parkingSlot}',
                  style: TextStyle(fontSize: 16.sp),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 70),
                Text(
                  'Time Duration: ${bookDetails.timeDuration.inHours} hours',
                  style: TextStyle(fontSize: 16.sp),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 70),
                Text(
                  'Price per Hour: \$${bookDetails.pricePerHour.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
