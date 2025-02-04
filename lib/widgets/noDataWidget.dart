import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoDataWidget extends StatelessWidget {
  final String? message;

  // Constructor to accept the message parameter
  const NoDataWidget({Key? key, this.message}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            width: 250,
            child:
            //Container(color: Colors.red,)
            SvgPicture.asset(
                "assets/icon/nodata.svg",
                semanticsLabel: 'Acme Logo'
            ),
          ),
          SizedBox(height: 20),
          Text(message ?? 'No Data Found!', style: TextStyle(
            fontFamily: 'OpenSans-SemiBold',
            fontSize: 14,
          )),
        ],
      ),
    );
  }
}
class CalDateWidget extends StatelessWidget {
  final selectedDate;
  CalDateWidget({this.selectedDate});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            width: 250,
            child:
            //Container(color: Colors.red,)
            SvgPicture.asset(
                "assets/icon/booking.svg",
                semanticsLabel: 'Acme Logo'
            ),
          ),
          const SizedBox(height: 0),
          Padding(
            padding: const EdgeInsets.only(left:20.0,right:20.0),
            child: Text("Appointment Date: $selectedDate",style: TextStyle(
              fontFamily: 'OpenSans-SemiBold',
              fontSize: 14,
            )),
          ),
        ],
      ),
    );
  }
}
class NoBookingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            width: 250,
            child:
            //Container(color: Colors.red,)
            SvgPicture.asset(
                "assets/icon/booking.svg",
                semanticsLabel: 'Acme Logo'
            ),
          ),
          SizedBox(height: 0),
          Padding(
            padding: const EdgeInsets.only(left:20.0,right:20.0),
            child: Text("There is no appointment Found! please press Book an appointment button and make a new appointment",style: TextStyle(
              fontFamily: 'OpenSans-SemiBold',
              fontSize: 14,
            )),
          ),
        ],
      ),
    );
  }
}
