import 'package:demopatient/utilities/color.dart';
import 'package:flutter/material.dart';
class DeleteButtonWidget extends StatelessWidget {
  @required
  final title;
  @required
  final onPressed;
  DeleteButtonWidget({this.onPressed, this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        8,
        20,
        8,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: btnColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
          ),
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
class SmallButtonsWidget extends StatelessWidget {
  @required
  final String? title;
  @required
  final onPressed;
  SmallButtonsWidget({this.title, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        ),
        onPressed: onPressed,
        child: Text(title ?? "", style: TextStyle(fontSize: 14)));
  }
}

class RoundedBtnWidget extends StatelessWidget {
  @required
  final String? title;
  @required
  final onPressed;
  RoundedBtnWidget({this.onPressed, this.title});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title ?? "",
            style: TextStyle(color: Colors.white),
          ),
        ));
  }
}
