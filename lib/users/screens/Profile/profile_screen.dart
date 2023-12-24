import 'package:share_plus/share_plus.dart';
import 'package:swizzle/consts/consts.dart';
import 'package:swizzle/users/controllers/current_user.dart';
import 'package:swizzle/users/screens/Privacy/privacy_screen.dart';
import 'package:swizzle/users/screens/purchase_history/purchase_history.dart';
import 'package:swizzle/users/screens/terms&conditons/terms_and_condition_screen.dart';
import 'package:swizzle/users/user_prefes/user_info_on_local_storage.dart';

import '../../controllers/custom_bottom_sheet.dart';

class ProfileScreen extends StatelessWidget {
  var controller = Get.find<CurrentUser>();
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: profile.text.make(),
      ),
      body: Container(
        color: Colors.white54,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  maxRadius: 65,
                  foregroundImage: AssetImage(icAppLogo),
                  backgroundColor: Colors.white,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            controller.user.user_name.text.size(26).bold.makeCentered(),
            controller.user.user_email.text.makeCentered(),
            const SizedBox(
              height: 15,
            ),
            Expanded(
                child: ListView(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              children: [
                Card(
                  margin:
                      const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: const ListTile(
                    leading: Icon(
                      Icons.privacy_tip_sharp,
                      color: Colors.black54,
                    ),
                    title: Text(
                      privacy,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.black54,
                    ),
                  ),
                ).onTap(() {
                  Get.to(() => const PrivacyScreen());
                }),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.white70,
                  margin:
                      const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: const ListTile(
                    leading: Icon(
                      Icons.history,
                      color: Colors.black54,
                    ),
                    title: Text(
                      purchageHistory,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.black54,
                    ),
                  ),
                ).onTap(() {
                  Get.to(() => const PurchaseHistoryScreen());
                }),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.white70,
                  margin:
                      const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: const ListTile(
                    leading: Icon(Icons.help_outline, color: Colors.black54),
                    title: Text(
                      termsAndConditions,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.black54,
                    ),
                  ),
                ).onTap(() {
                  Get.to(() => const TermsAndConditionScreen());
                }),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.white70,
                  margin:
                      const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: const ListTile(
                    leading: Icon(
                      Icons.add_reaction_sharp,
                      color: Colors.black54,
                    ),
                    title: Text(
                      inviteAFriend,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.black54,
                    ),
                  ),
                ).onTap(() {
                  Share.share(
                    '$heyIamUsing $appName $appLink',
                    subject: comeAndJoinMe,
                  );
                }),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.white70,
                  margin:
                      const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: const ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.black54,
                    ),
                    title: Text(
                      logout,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                ).onTap(() {
                  CustomBottomSheet().openBottomSheet(
                    context,
                    areYouSureWantToLogout,
                    () {
                      UserPrefes.clearUserData();
                    },
                    yes,
                  );
                })
              ],
            ))
          ],
        ),
      ),
    );
  }
}
