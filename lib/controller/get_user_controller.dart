
import 'package:demopatient/Service/userService.dart';
import 'package:get/get.dart';


class GetUserController extends GetxController{
  var isLoading=false.obs; //Loading for data fetching
  var dataList= [].obs; //Object of blog post model
  var isError=false.obs; // Error handling

  @override
  void onInit() {
    // TODO: implement onInit
    getData(); //fetching data
    super.onInit();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    //   scrollController.dispose();
    super.dispose();
  }
  void getData()async{

    isLoading(true);
    //   dataList.value=[];
    try{
      final getDataList=await UserService.getData();
      //Get all blog post list details from the blog post service page
      if (getDataList.isNotEmpty) {
        dataList.value=getDataList;
      } else {
        isError(true);
      } // If its error
    }
    catch(e){
      isError(true);  // If its error
    }
    finally{
      isLoading(false); // Run try block with error ot without error
    }

  }


}
