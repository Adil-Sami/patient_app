import 'package:demopatient/Service/closingDateService.dart';
import 'package:demopatient/Service/drProfileService.dart';
import 'package:demopatient/SetData/screenArg.dart';
import 'package:demopatient/utilities/color.dart';
import 'package:demopatient/utilities/toastMsg.dart';
import 'package:demopatient/widgets/appbarsWidget.dart';
import 'package:demopatient/widgets/bottomNavigationBarWidget.dart';
import 'package:demopatient/widgets/loadingIndicator.dart';
import 'package:demopatient/widgets/noDataWidget.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:get/get.dart';

class WalkinReschTimeSlotPage extends StatefulWidget {
  final appId;
  final appDate;
  final firstNameController;
  final lastNameController;
  final phoneNumberController;
  final emailController;
  final ageController;
  final selectedGender;
  final cityController;
  final desController;
  final serviceName;
  final serviceTimeMin;
  final deptName;
  final doctName;
  final hospitalName;
  final doctId;
  final clinicId;
  final cityId;
  final deptId;
  final cityName;
  final clinicName;

  const WalkinReschTimeSlotPage(
      {Key? key,
      this.appId,
      this.appDate,
      this.firstNameController,
      this.lastNameController,
      this.phoneNumberController,
      this.emailController,
      this.ageController,
      this.selectedGender,
      this.cityController,
      this.desController,
      this.serviceName,
      this.serviceTimeMin,
      this.deptName,
      this.hospitalName,
      this.doctName,
      this.doctId,
      this.cityId,
      this.clinicId,
      this.deptId,
      this.cityName,
      this.clinicName})
      : super(key: key);

  @override
  _WalkinReschTimeSlotPageState createState() =>
      _WalkinReschTimeSlotPageState();
}

class _WalkinReschTimeSlotPageState extends State<WalkinReschTimeSlotPage> {
  bool _isLoading = false;
  String _setTime = "";
  var _selectedDate;
  var _selectedDay = DateTime.now().weekday;
  List _closingDate = [];
  Map closingTime = Map();
  List _dayCode = [];
  String fee = "";
  String opt = "";
  String clt = "";
  String lopt = "";
  String lclt = "";
  String closingDay = "";
  @override
  void initState() {
    _setTime =
        DateTime.now().hour.toString() + ":" + DateTime.now().minute.toString();
    super.initState();
    _getAndSetAllInitialData();
  }

  _getAndSetAllInitialData() async {
    setState(() {
      _isLoading = true;
    });

    _selectedDate = await _initializeDate(); //Initialize start time

    await _setClosingDate();
    //await _getAndSetbookedTimeSlots();
    // await _getAndSetOpeningClosingTime();
    // _getAndsetTimeSlots(
    //     _openingTimeHour, _openingTimeMin, _closingTimeHour, _closingTimeMin);

    setState(() {
      _isLoading = false;
    });
  }


  Future<String> _initializeDate() async {
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate = "${dateParse.month}-${dateParse.day}-${dateParse.year}";

    return formattedDate;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationStateWidget(
          title: "Next".tr,
          onPressed: _isLoading
              ? null
              : () {
                  if (_closingDate.contains(_selectedDate) ||
                      _dayCode.contains(_selectedDay))
                    ToastMsg.showToastMsg(
                        "Doctor not taking appointment on".tr+" $_selectedDate date");
                  else
                    Navigator.pushNamed(
                      context,
                      '/WalkinReschConfirmationPage',
                      arguments: PatientDetailsArg(
                          widget.firstNameController,
                          widget.lastNameController,
                          widget.phoneNumberController,
                          widget.emailController,
                          widget.ageController,
                          widget.selectedGender,
                          widget.cityController,
                          widget.desController,
                          widget.serviceName,
                          widget.serviceTimeMin,
                          "As per availability",
                          _selectedDate,
                          widget.doctName,
                          widget.deptName,
                          widget.hospitalName,
                          widget.doctId,
                          fee,
                          widget.deptId,
                          widget.cityId,
                          widget.clinicId,
                          widget.clinicName,
                          widget.cityName,
                          widget.appId,
                          widget.appDate,
                          "",
                          "",
                          "",
                          ""),
                    );
                },
          clickable: _setTime,
        ),
        body: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            CAppBarWidget(title: "Book an appointment".tr),
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 10, right: 10),
                          child: SingleChildScrollView(
                            // controller: _scrollController,
                            child: Column(
                              children: <Widget>[
                                _buildCalendar(),
                                Divider(),
                                _isLoading
                                    ? LoadingIndicatorWidget()
                                    : _closingDate.contains(_selectedDate) ||
                                            _dayCode.contains(_selectedDay)
                                        ? Center(
                                            child: Text(
                                            "Sorry! we can't take appointments in this day".tr,
                                            style: TextStyle(
                                              fontFamily: 'OpenSans-SemiBold',
                                              fontSize: 14,
                                            ),
                                          ))
                                        : CalDateWidget(
                                            selectedDate: _selectedDate)
                                // Column(
                                //   children: <Widget>[
                                //     _morningTimeSlotsList.length == 0
                                //         ? Container()
                                //         : Padding(
                                //       padding:
                                //       const EdgeInsets.only(
                                //           top: 20.0),
                                //       child: Text(
                                //           "Morning Time Slot",
                                //           style: TextStyle(
                                //             fontFamily:
                                //             'OpenSans-SemiBold',
                                //             fontSize: 14,
                                //           )),
                                //     ),
                                //     _morningTimeSlotsList.length == 0
                                //         ? Container()
                                //         : _slotsGridView(
                                //         _morningTimeSlotsList,
                                //         _bookedTimeSlots,
                                //         widget.serviceTimeMin),
                                //     _afternoonTimeSlotsList.length ==
                                //         0
                                //         ? Container()
                                //         : Padding(
                                //       padding:
                                //       const EdgeInsets.only(
                                //           top: 20.0),
                                //       child: Text(
                                //           "Afternoon Time Slot",
                                //           style: TextStyle(
                                //             fontFamily:
                                //             'OpenSans-SemiBold',
                                //             fontSize: 14,
                                //           )),
                                //     ),
                                //     _afternoonTimeSlotsList.length ==
                                //         0
                                //         ? Container()
                                //         : _slotsGridView(
                                //         _afternoonTimeSlotsList,
                                //         _bookedTimeSlots,
                                //         widget.serviceTimeMin),
                                //     _eveningTimeSlotsList.length == 0
                                //         ? Container()
                                //         : Padding(
                                //       padding:
                                //       const EdgeInsets.only(
                                //           top: 20.0),
                                //       child: Text(
                                //           "Evening Time Slot",
                                //           style: TextStyle(
                                //             fontFamily:
                                //             'OpenSans-SemiBold',
                                //             fontSize: 14,
                                //           )),
                                //     ),
                                //     _eveningTimeSlotsList.length == 0
                                //         ? Container()
                                //         : _slotsGridView(
                                //         _eveningTimeSlotsList,
                                //         _bookedTimeSlots,
                                //         widget.serviceTimeMin),
                                //   ],
                                // )
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildCalendar() {
    return DatePicker(
      DateTime.now(),
      initialSelectedDate: DateTime.now(),
      selectionColor: appBarColor,
      selectedTextColor: Colors.white,
      daysCount: 7,
      onDateChange: (date) {
        // New date selected
        setState(() {
          final dateParse = DateTime.parse(date.toString());

          _selectedDate =
              "${dateParse.month}-${dateParse.day}-${dateParse.year}";
          _selectedDay = date.weekday;
          //  _reCallMethodes();
        });
      },
    );
  }




  _setClosingDate() async {
    setState(() {
      _isLoading = true;
    });
    final res = await ClosingDateService.getData(
        widget.doctId); // ReadData.fetchSettings();
    if (res.isNotEmpty) {
      for (var e in res) {
        if (e.allDay == "1") {
          print(";;;;;;;;;llllllllllllllll${e.date}");
          setState(() {
            _closingDate.add(e.date);
            //res["closingDate"];
          });
        } else if (e.allDay == "0") {
          setState(() {
            closingTime[e.date] = [];
            closingTime[e.date].addAll(e.blockTime);
            print("LCccccccccccc${closingTime}");
          });
        }
      }
    }
    final getDoct = await DrProfileService.getDataByDrId(widget.doctId);
    if (getDoct[0].closingDate != "" && getDoct[0].closingDate != null) {
      final coledDatArr = (getDoct[0].closingDate)!.split(',');
      for (var element in coledDatArr) {
        _closingDate.add(int.parse(element));
      }
    }

    opt = getDoct[0].opt!;
    clt = getDoct[0].clt!;
    lopt = getDoct[0].lunchOpeningTime!;
    lclt = getDoct[0].lunchClosingTime!;
    closingDay = getDoct[0].dayCode!;

    fee = getDoct[0].fee!;
    print("8888888888888888888");
    print(widget.cityId);
    print(widget.clinicId);
    print(widget.deptId);
    print("8888888888888888888");
    setState(() {
      _isLoading = false;
    });
    // serviceName;
    // serviceTimeMin;
    //
    // deptName;
    // doctName;
    // hospitalName;
    // doctId;
    //
    //
    //  clinicId;
    // cityId;
    // deptId;
    // cityName;
    // clinicName;
  }
}
