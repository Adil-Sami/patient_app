import 'package:demopatient/utilities/color.dart';
import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatelessWidget {
  @required
  final String? title;
  @required
  final String? route;
  BottomNavigationWidget({this.title, this.route});
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 12.0, bottom: 12.0), // top bottom old value is 8 + left right old value is 20 + hassan005004
        child: SizedBox(
          height: 45, // old value is 35 + hassan005004
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: btnColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
              child: Center(
                  child: Text(title ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ))),
              onPressed: () {
                Navigator.pushNamed(context, route!);
              }),
        ),
      ),
    );
  }
}

class BottomNavigationTwoWidget extends StatelessWidget {
  @required
  final String? title;
  @required
  final onTap;
  @required
  final String? title2;
  @required
  final onTap2;
  BottomNavigationTwoWidget({this.title, this.onTap, this.title2, this.onTap2});
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 12.0, bottom: 12.0), // top bottom old value is 8 + left right old value is 20 + hassan005004
        child: SizedBox(
          height: 45, // old value is 35 + hassan005004
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: btnColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    child: Center(
                        child: Text(title ?? "",
                            style: TextStyle(
                              color: Colors.white,
                                fontWeight: FontWeight.bold
                            ))),
                    onPressed: onTap),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: btnColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    child: Center(
                        child: Text(title2 ?? "",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ))),
                    onPressed: onTap2),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavigationUrlWidget extends StatelessWidget {
  @required
  final String? title;
  @required
  final onTap;
  BottomNavigationUrlWidget({this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 12.0, bottom: 12.0), // top bottom old value is 8 + left right old value is 20 + hassan005004
        child: SizedBox(
          height: 45, // old value is 35 + hassan005004
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: btnColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
              child: Center(
                  child: Text(title ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ))),
              onPressed: onTap),
        ),
      ),
    );
  }
}

class BottomNavigationStateWidget extends StatelessWidget {
  @required
  final String? title;
  @required
  final String? clickable;
  @required
  final onPressed;
  BottomNavigationStateWidget({this.title, this.onPressed, this.clickable});
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        // notchMargin: 4.0,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15, top: 12.0, bottom: 12.0), // top bottom old value is 8 + left right old value is 20 + hassan005004
          child: SizedBox(
            height: 45, // old value is 35 + hassan005004
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: btnColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                child: Center(
                    child: Text(title ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ))),
                onPressed: clickable == "" ? null : onPressed),
          ),
        ));
  }
}
