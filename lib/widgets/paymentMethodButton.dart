import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../utilities/color.dart';

class PaymentMethodButton extends StatelessWidget {

  @required
  final String title;
  @required
  final int isSelected;
  @required
  final dynamic amount;
  @required
  void onPressed;

  PaymentMethodButton({required this.title, required this.isSelected, required this.amount, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed as void Function(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 45,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: btnColor.withOpacity(0.1),
                border: Border.all(
                    width: isSelected == 1 ? 2.0 : 2.0,
                    color: isSelected == 1 ? btnColor : btnColor.withOpacity(0.1)
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(10.0) //                 <--- border radius here
                ),
              ),
              child: Row(
                children: [
                  Text(title.tr),
                  Spacer(),
                  isSelected == 1 ? Icon(Icons.check, color: btnColor,) : Center()
                ],
              ),
            ),
            isSelected == 1 ?
            // newAmount == null ?
            Text("Pay Amount: Rs.".tr + amount.toString()) :
            // Text("Pay Amount: Rs.".tr + newAmount.toString()) :
            Container(),
          ],
        )
    );
  }
}