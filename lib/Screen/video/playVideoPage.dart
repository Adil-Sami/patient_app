import 'package:demopatient/utilities/color.dart';
import 'package:demopatient/utilities/style.dart';
import 'package:demopatient/widgets/imageWidget.dart';
import 'package:demopatient/widgets/videoPlayerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlayVideoPage extends StatefulWidget {
  final title;
  final timeStamp;
  final videoList;
  final videoUrl;
  PlayVideoPage({this.title, this.videoList, this.timeStamp, this.videoUrl});
  @override
  _PlayVideoPageState createState() => _PlayVideoPageState();
}

class _PlayVideoPageState extends State<PlayVideoPage> {

  String _videoUrl = "";
  String _videoTimeStamp = "";
  String _videoTitle = "";

  ScrollController _scrollController = new ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    setState(() {
      _videoUrl = widget.videoUrl;
      _videoTimeStamp = widget.timeStamp;
      _videoTitle = widget.title;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        if (MediaQuery.of(context).orientation == Orientation.portrait)
          Navigator.pop(context);
        else
          SystemChrome.setPreferredOrientations(
              [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

        return false;
      },
      child: Scaffold(
          appBar: MediaQuery.of(context).orientation == Orientation.portrait
              ? AppBar(
                  title: Text(
                    _videoTitle,
                    style: kAppbarTitleStyle,
                  ),
                  backgroundColor: appBarColor,
                )
              : null,
          body: MediaQuery.of(context).orientation == Orientation.portrait
              ? ListView(
                  controller: _scrollController,
                  children: [
                   VideoPlayerWidget(videoUrl: _videoUrl),
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? _buildHeader()
                        : Container(),
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? Divider()
                        : Container(),
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? _buildList(widget.videoList)
                        : Container(),
                  ],
                )
              : Column(
                  children: [
                   Expanded(child: VideoPlayerWidget(videoUrl: _videoUrl)),
                  ],
                )
          //
          // ListView(
          //   controller: _scrollController,
          //   children: [
          //     VideoPlayerWidget(videoUrl: _videoUrl),
          //     // MediaQuery.of(context).orientation == Orientation.portrait?_buildHeader():Container(),
          //     // MediaQuery.of(context).orientation == Orientation.portrait? Divider():Container(),
          //     // MediaQuery.of(context).orientation == Orientation.portrait?_buildList(widget.videoList):Container(),
          //   ],
          // ),
          ),
    );
  }

  Widget _buildList(videoDetails) {
    return Container(
      child: ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          controller: _scrollController,
          itemCount: videoDetails.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: _videoTitle == videoDetails[index].title
                  ? null
                  : () {
                Navigator.pop(context);
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
                      // setState(() {
                      //   _videoTitle = videoDetails[index].title;
                      //   _videoUrl = videoDetails[index].videoUrl;
                      //   _videoTimeStamp = videoDetails[index].createdTimeStamp;
                      //   _selectedIndex = index;
                      //   print(_selectedIndex);
                      // });
                    },
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
                  style: kCadSubTitleStyle,
                ),
                trailing: IconButton(
                    onPressed: () {},
                    icon: CircleAvatar(
                        radius: 10,
                        backgroundColor:
                        _videoTitle == videoDetails[index].title ? Colors.red : iconsColor,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Colors.white,
                        ))),
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
            );
          }),
    );
  }

  _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        _videoTitle + " | " + _videoTimeStamp,
        style: kCadTitleStyle,
      ),
    );
  }
}
