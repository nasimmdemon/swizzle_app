// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:swizzle/Api/api_connection.dart';
import 'package:swizzle/consts/consts.dart';

class ItemUploadController extends GetxController {
  final picker = ImagePicker();
  var isLoading = false.obs;
  var isUploading = false.obs;
  File? image_file;
  XFile? image_xfile;
  String image_link = '';

  //text editing controllers
  var itemNameController = TextEditingController();
  var itemDescController = TextEditingController();
  var itemPriceController = TextEditingController();

  Future pickImageFromPhoneGallery() async {
    isLoading(true);
    image_xfile = await picker.pickImage(source: ImageSource.gallery);
    image_file = File(image_xfile!.path);
    isLoading(false);
  }

  uploadImage() async {
    isUploading(true);
    Fluttertoast.showToast(msg: pleaseWait);
    try {
      var requestImgurApi = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.imgur.com/3/image'),
      );
      String imageName = DateTime.now().microsecondsSinceEpoch.toString();
      requestImgurApi.fields['title'] = imageName;
      requestImgurApi.headers['Authorization'] = "Client-ID " "52747bc90d9e597";

      var imageFile = await http.MultipartFile.fromPath(
          'image', image_file!.path,
          filename: imageName);

      requestImgurApi.files.add(imageFile);
      var resFormImgurApi = await requestImgurApi.send();
      var resDataFromImgurApi = await resFormImgurApi.stream.toBytes();
      var resultFromImgurApi = String.fromCharCodes(resDataFromImgurApi);
      var imgurJsonData = jsonDecode(resultFromImgurApi);
      image_link = imgurJsonData['data']['link'];
      uploadProductOnDatabase();
      Fluttertoast.showToast(msg: imageUploaded);
      isUploading(false);
    } catch (e) {
      isUploading(false);

      print(e.toString());
    }
  }

  uploadProductOnDatabase() async {
    try {
      var res = await http.post(Uri.parse(Api.adminUpload), body: {
        'item_name': itemNameController.text.trim(),
        'item_description': itemDescController.text.trim(),
        'item_price': itemPriceController.text.trim(),
        'item_image': image_link.toString(),
        'item_status': '1',
        'item_type': 'simple',
      });

      if (res.statusCode == 200) {
        print('Uploaded');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
