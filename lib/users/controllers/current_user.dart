import 'package:swizzle/consts/consts.dart';
import 'package:swizzle/users/model/user.dart';
import 'package:swizzle/users/user_prefes/user_info_on_local_storage.dart';

class CurrentUser extends GetxController {
  final Rx<User> _currentUser = User(0, '', '', '').obs;

  User get user => _currentUser.value;

  getUserInfo() async {
    User? userInfoFromLocalStorage = await UserPrefes.readUserPrefes();
    _currentUser.value = userInfoFromLocalStorage!;
  }
}
