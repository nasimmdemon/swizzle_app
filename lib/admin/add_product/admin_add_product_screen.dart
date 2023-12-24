import 'package:dotted_border/dotted_border.dart';
import 'package:swizzle/consts/consts.dart';
import 'package:swizzle/widgets/custom_button.dart';
import 'package:swizzle/widgets/custom_test_field.dart';

import '../controllers/item_upload_controller.dart';

class AdminAddProductScreen extends StatelessWidget {
  var controller = Get.put(ItemUploadController());
  final formKey = GlobalKey<FormState>();

  AdminAddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white60,
        appBar: AppBar(
          title: addProduct.text.make(),
        ),
        body: controller.isUploading.value
            ? Container(
                child: Image.asset(
                  uploadingImage,
                  fit: BoxFit.cover,
                ),
              )
            : Form(
                key: formKey,
                child: ListView(
                  physics: const ScrollPhysics(),
                  children: [
                    30.heightBox,
                    Center(
                        child: DottedBorder(
                      child: controller.isLoading.value
                          ? SizedBox(
                              height: 250,
                              width: 250,
                              child: loadingImage.text.size(22).makeCentered(),
                            )
                          : SizedBox(
                              height: 250,
                              width: 250,
                              child: controller.image_file == null
                                  ? preview.text.size(18).makeCentered()
                                  : Image.file(controller.image_file!,
                                      fit: BoxFit.cover),
                            ),
                    )),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        4.widthBox,
                        '$itemType :'.text.make(),
                        4.widthBox,
                        Icon(controller.itemType.value == 0
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off_outlined)
                            .onTap(() {
                          controller.itemType.value = 0;
                        }),
                        simpleItem.text.make(),
                        4.widthBox,
                        Icon(controller.itemType.value == 1
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off_outlined)
                            .onTap(() {
                          controller.itemType.value = 1;
                        }),
                        variableItem.text.make(),
                      ],
                    ),
                    10.heightBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 75, vertical: 10),
                      child: customButton(
                          title: controller.image_file == null
                              ? pickImage
                              : changeImage,
                          ontap: () {
                            controller.pickImageFromPhoneGallery();
                          }),
                    ),
                    Column(
                      children: [
                        10.heightBox,
                        customTextField(
                            controller: controller.itemNameController,
                            label: itemName,
                            hint: itemNameHint,
                            inputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return basicValidation;
                              } else {
                                return null;
                              }
                            },
                            inputType: TextInputType.text),
                        10.heightBox,
                        customTextField(
                          controller: controller.itemDescController,
                          label: itemDescription,
                          hint: itemDescriptionHint,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return basicValidation;
                            } else {
                              return null;
                            }
                          },
                          inputType: TextInputType.multiline,
                          maxLines: 3,
                          inputAction: TextInputAction.newline,
                        ),
                        10.heightBox,
                        customTextField(
                            controller: controller.itemPriceController,
                            label: itemPrice,
                            hint: itemPriceHint,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return basicValidation;
                              } else {
                                return null;
                              }
                            },
                            inputType: TextInputType.number),
                        10.heightBox,
                        customTextField(
                            controller: controller.itemSalePriceController,
                            label: itemSalePrice,
                            hint: itemSalePriceHint,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return basicValidation;
                              } else {
                                return null;
                              }
                            },
                            inputType: TextInputType.number),
                        10.heightBox,
                        controller.itemType.value == 1
                            ? customTextField(
                                controller: controller.itemVariationsController,
                                label: itemVariations,
                                hint: itemVariationHints,
                                inputType: TextInputType.text)
                            : Container(),
                        10.heightBox,
                        customButton(
                            title: uploadProduct,
                            ontap: () {
                              if (formKey.currentState!.validate()) {
                                controller.uploadImage();
                              }
                            })
                      ],
                    )
                        .box
                        .clip(Clip.antiAlias)
                        .padding(const EdgeInsets.all(16))
                        .make()
                  ],
                ),
              ),
      ),
    );
  }
}
