import 'dart:convert';

import 'package:swizzle/Api/api_connection.dart';
import 'package:swizzle/consts/consts.dart';
import 'package:http/http.dart' as http;

class AppStatus extends GetxController {
  RxInt appStatus = 1.obs;

  Future<int> checkAppStatus() async {
    try {
      var res = await http.post(Uri.parse(Api.appStatus), body: {
        'app_version': version.toString(),
      });

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          var appDetail = resBody['appDetail'];
          return int.parse(appDetail['app_status']);
        }
        return int.parse(resBody['appDetail']['app_status']);
      } else {
        return 1;
      }
    } catch (error) {
      rethrow;
    }
  }
}
