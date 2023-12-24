import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:swizzle/consts/consts.dart';

class UpdateDialogueIos extends GetxController {
  showDialogue(
      {context,
      required String title,
      required String content,
      required String agreeBtnTitle,
      agreeBtnOntap,
      String? declineBtnTitle,
      Function? deClineBtnOntap}) {
    showCupertinoModalPopup(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
              title: const Text(updateAvailible),
              content: const Text(updateAvailiblePleaseUpdateTheApp),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  /// This parameter indicates this action is the default,
                  /// and turns the action's text to bold text.
                  isDefaultAction: true,
                  onPressed: () {
                    exit(0);
                  },
                  child: Text(agreeBtnTitle),
                ),
              ]);
        });
  }
}
