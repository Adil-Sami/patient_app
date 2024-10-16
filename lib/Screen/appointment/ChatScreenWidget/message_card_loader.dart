import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget MessageCardShimmer(int color, Alignment alignment){
  return Align(
    alignment: alignment,
    child: SizedBox(
      height: 60,
      width: 250,
      child: Shimmer.fromColors(
        baseColor: Color(color),
        highlightColor: Color(color).withOpacity(0.5),
        child: Card(
          elevation: 0.0,
          margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius
                .circular(8),
          ),
          child: const SizedBox(
              height: 60),
        ),
      ),
    ),
  );
}
 const senderColor = 0xFFDCF8C6;
 const receiverColor = 0xFFF6F6F6;
Widget MessageScreenShimmer() {
  return Column(
      children: [
        MessageCardShimmer(senderColor, Alignment.centerRight),
        MessageCardShimmer(receiverColor, Alignment.centerLeft),
        MessageCardShimmer(senderColor, Alignment.centerRight),
        MessageCardShimmer(receiverColor, Alignment.centerLeft),
        MessageCardShimmer(senderColor, Alignment.centerRight),
        MessageCardShimmer(receiverColor, Alignment.centerLeft),
        MessageCardShimmer(senderColor, Alignment.centerRight),
        MessageCardShimmer(receiverColor, Alignment.centerLeft),
        MessageCardShimmer(senderColor, Alignment.centerRight),
      ]
  );
}