import 'dart:io';

import 'package:swizzle/consts/consts.dart';

class UpdateDialogueAndroid extends GetxController {
  showDialogue(
      {context,
      required String title,
      required String content,
      required String agreeBtnTitle,
      agreeBtnOntap,
      String? declineBtnTitle,
      Function? deClineBtnOntap}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return AlertDialog(
              title: const Text(updateAvailible),
              content: const Text(updateAvailiblePleaseUpdateTheApp),
              actions: <Widget>[
                TextButton(
                  /// This parameter indicates this action is the default,
                  /// and turns the action's text to bold text.

                  onPressed: () {
                    exit(0);
                  },
                  child: Text(agreeBtnTitle),
                ),
              ]);
        });
  }
}
