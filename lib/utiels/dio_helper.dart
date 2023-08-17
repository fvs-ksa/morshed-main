
import 'package:dio/dio.dart';

import '../constant/const_color.dart';
import 'baseurl.dart';


class DioHelper {
  static Dio dio = Dio();
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: BaseUrl.baseUrl,
      receiveDataWhenStatusError: true,
      headers: {
         'Authorization':"Bearer $token",
        'Accept':'application/json',
        'Content-Type': 'application/json'

        //'zoneId':zone_ids,
      },
    ));
  }

  static Future<Response> getData(
      {required String url, Map<String, dynamic>? query, String? token,String? search}) async {
    dio.options.headers = {
      "Authorization": 'Bearer $token' ?? "",
      'Content-Type': 'application/json'
    };
    dio.options.queryParameters={
      'lang': myLocale,
      'search_query':search
    };
    Response response;
    // return

    response =await dio.get(url, queryParameters: query);

    print('RESPONSE:##$response');
    print('STATUS CODE: ${response.statusCode}');

    return response;
    // var response;
    // try{
    //   response= await dio.get(url, queryParameters: query);
    // }on DioError catch (e){
    //   if (e.response != null) {
    //     response = e.response;
    //     print("response: " + e.response.toString());
    //   } else {}
    // }
    // return handleResponse(response);
  }
  static Future<Response>deleteData({required String url,String? token})async{
    dio.options.headers={
      "Authorization": 'Bearer $token',
      'Content-Type': 'application/json'
    };
    return await dio.delete(url);
    // try{
    //   var response;
    //   response=await dio.delete(
    //     url,
    //    // queryParameters: query,
    //    // data: data,
    //   );
    // }on DioError catch(e){}
    // var response;
    // try{
    //   response=   await dio.post(
    //     url,
    //     // queryParameters: query,
    //     // data: data,
    //   );
    // }on DioError catch (e){
    //   if (e.response != null) {
    //     response = e.response;
    //     print("response: " + e.response.toString());
    //     print(response);
    //   }
    // }
    // return handleResponse(response);

  }

  static Future<Response> postData(
      {required String url,
        Map<String, dynamic>? query,
        String? token,
        Map<String, dynamic>? data}) async {
    dio.options.headers = {
      "Authorization": 'Bearer $token',
      'Content-Type': 'application/json'
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
    // var response;
    // try {
    //   response = await dio.post(url, queryParameters: query);
    // } on DioError catch (e) {
    //   if (e.response != null) {
    //     response = e.response;
    //     print("response: " + e.response.toString());
    //   } else {}
    // }
    // return handleResponse(response);
  }



  static Future<Response> handleResponse(
      Response response,) async {
    if (response == null || response.data.runtimeType == String) {
      return Response(
        statusCode: 102,
        data: {
          "mainCode": 0,
          "code": 102,
          "data": null,
          "error": [
            {"key": "internet", "value": "هناك خطا يرجي اعادة المحاولة"}
          ]
        },
        requestOptions: RequestOptions(),);
    } else {

      final int? statusCode = response.statusCode;
      print("response: " + response.toString());
      print("statusCode" + statusCode.toString());


      if (statusCode! >= 200 && statusCode < 300) {
        //showToast(text: response.data['status']!, state: ToastState.SUCCESS);
        return response;

      } else if (statusCode == 401) {
        // showToast(text: response.statusMessage!, state: ToastState.ERROR);
        // CacheHelper.removeData(key: 'token');
        // CacheHelper.removeData(key: 'user_type');
        // navigateForwardReplace(BoardingScreen());
        // navigateAndFinish(myContext(), LoginScreen());
        return Response(
          statusCode: 401,
          data: {
            "mainCode": 0,
            "code": 401,
            "data": null,
            "error": [
              {"key": "internet", "value": "انتهت مده التسجيل"}
            ]
          },
          requestOptions: RequestOptions(),
          // requestOptions: null
        );
      } else {
        return response;
      }
    }
  }
}
// dio.options.headers= {
//   "Authorization":'$token'??"",
//   'Content-Type': 'application/json'
//   // "zoneId":zone
// };
// dio.options.headers= {"Authorization":'$token',};
