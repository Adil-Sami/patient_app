import 'package:demopatient/Screen/video/playVideoPage.dart';
import 'package:demopatient/Service/videoService.dart';
import 'package:demopatient/utilities/color.dart';
import 'package:demopatient/utilities/style.dart';
import 'package:demopatient/widgets/appbarsWidget.dart';
import 'package:demopatient/widgets/errorWidget.dart';
import 'package:demopatient/widgets/imageWidget.dart';
import 'package:demopatient/widgets/loadingIndicator.dart';
import 'package:demopatient/widgets/noDataWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/paddingAdjustWidget.dart';

class VideoListPage extends StatefulWidget {
  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  ScrollController _scrollController = new ScrollController();
  int limit = 10;
  int itemLength = 0;
  @override
  void initState() {
    // TODO: implement initState
    _scrollListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          CAppBarWidget(title: "Video".tr),
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
              child: FutureBuilder(
                  future: VideoService.getData(
                      limit), //fetch all testimonials details
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData)
                      return snapshot.data.length == 0
                          ? NoDataWidget()
                          : _buildList(snapshot.data);
                    else if (snapshot.hasError)
                      return IErrorWidget(); //if any error then you can also use any other widget here
                    else
                      return LoadingIndicatorWidget();
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildList(videoDetails) {
    itemLength = videoDetails.length;
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: videoDetails.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlayVideoPage(
                            title: videoDetails[index].title,
                            videoList: videoDetails,
                            timeStamp: videoDetails[index].createdTimeStamp,
                            videoUrl: videoDetails[index].videoUrl,
                          )),
                );
              },
              child: PaddingAdjustWidget(
                index: index,
                itemInRow: 1,
                length: videoDetails.length,
                child: ListTile(
                  title: Text(
                    videoDetails[index].title,
                    style: kCadTitleStyle,
                  ),
                  subtitle: Text(
                    videoDetails[index]
                        .createdTimeStamp
                        .toString()
                        .substring(0, 10),
                    style: kCardSubTitleStyle,
                  ),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      )),
                  leading: Container(
                    height: 100,
                    width: 80,
                    child: videoDetails[index].imageUrl == ""
                        ? Icon(
                            Icons.category,
                            color: iconsColor,
                            size: 30,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: ImageBoxFillWidget(
                              imageUrl: videoDetails[index].imageUrl,
                            )),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void _scrollListener() {
    _scrollController.addListener(() {
      // print("length" $itemLength $limit");
      if (itemLength >= limit) {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          setState(() {
            limit += 10;
          });
        }
      }
    });
  }
}
