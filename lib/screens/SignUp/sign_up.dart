import 'dart:io';

import 'package:firebase_project/Main/main.dart';
import 'package:firebase_project/services/firebase_cloud_storage_service.dart';
import 'package:firebase_project/utils/common_widgets/app_button.dart';
import 'package:firebase_project/utils/common_widgets/app_text_field.dart';
import 'package:firebase_project/utils/common_widgets/gradient_header.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:firebase_project/utils/constants/font_styles.dart';
import 'package:firebase_project/utils/device/device_utility.dart';
import 'package:firebase_project/utils/device/ui_helper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class SignUp extends ConsumerStatefulWidget {
  static const String routeName = 'signup';
  const SignUp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final storage = FirebaseStorageService.instance.firebaseStorage;
  final formKey = GlobalKey<FormBuilderState>();
  File? _photo;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(context),
          _buildForm(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return AppHeaderGradient(
      fixedHeight: MediaQuery.of(context).size.height * .25,
      isProfile: false,
      text: 'Profile Info',
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
        child: Container(
      margin: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              showModalSheet(context);
            },
            child: CircleAvatar(
              radius: 50.0,
              backgroundColor: AppColors.lightGrey,
              child: _photo != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(45.0),
                      child: Image.file(
                        _photo!,
                        width: 90,
                        height: 90,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(45.0)),
                      width: 90,
                      height: 90,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
            ),
          ),
          const Text('Upload photo'),
          UIHelper.verticalSpaceMedium(),
          formWidget(),
          UIHelper.verticalSpaceMedium(),
          AppButton.button(
              text: 'Save',
              textColor: AppColors.white,
              width: AppDeviceUtils.getScreenWidth(context),
              color: AppColors.primary,
              onTap: () {
                if (formKey.currentState!.saveAndValidate()) {
                  // Navigator.pushReplacementNamed(context, Main.routeName);
                }
              }),
          const SizedBox(height: 10.0),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, Main.routeName);
            },
            child: Text(
              'Skip',
              style: FontStyles.montserratBold17().copyWith(color: Colors.grey),
            ),
          ),
        ],
      ),
    ));
  }

  formWidget() {
    return FormBuilder(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormBuilderTextField(
            style: FontStyles.montserratRegular14(),
            name: 'name',
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: FontStyles.montserratRegular14(),
              prefixStyle: FontStyles.montserratRegular14(),
              prefixIcon: const Icon(
                Icons.person_2_outlined,
                color: AppColors.primary,
              ),
            ),
            // onChanged: (code) {
            //   if (code!.length == 10) {
            //     FocusScope.of(context).requestFocus(FocusNode());
            //   }
            // },
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Name is required'),
              FormBuilderValidators.maxLength(25),
            ]),
            keyboardType: TextInputType.text,
          ),
          UIHelper.verticalSpaceSmall(),
          FormBuilderTextField(
            style: FontStyles.montserratRegular14(),
            name: 'email',
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: FontStyles.montserratRegular14(),
              prefixStyle: FontStyles.montserratRegular14(),
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: AppColors.primary,
              ),
            ),
            // onChanged: (code) {
            //   if (code!.length == 10) {
            //     FocusScope.of(context).requestFocus(FocusNode());
            //   }
            // },
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Email is required'),
            ]),
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }

  showModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: ListTile(
                onTap: () {
                  imageFromGallery();
                  Navigator.of(context).pop();
                },
                leading: const Icon(Icons.settings_rounded),
                title: const Text('From gallery'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () {
                  imageFromCamera();
                  Navigator.of(context).pop();
                },
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('From Camera'),
              ),
            )
          ],
        );
      },
    );
  }

  Future imageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        // uploadeFile();
      } else {
        debugPrint("No image selected");
      }
    });
  }

  Future imageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        // uploadeFile();
      } else {
        debugPrint("No image selected");
      }
    });
  }

  Future uploadeFile() async {
    final fileName = basename(_photo!.path);
    final destination = 'user_photo/$fileName';
    late String downloadLink;

    try {
      final ref = storage.ref(destination);
      final result =
          ref.putFile(_photo!).snapshotEvents.listen((taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.running:
            final progress = 100.0 *
                (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
            print("Upload is $progress% complete.");
            break;
          case TaskState.paused:
            print("Upload is paused.");
            break;
          case TaskState.canceled:
            print("Upload was canceled");
            break;
          case TaskState.error:
            print("There's an error");
            break;
          case TaskState.success:
            await ref.getDownloadURL().then((value) {
              downloadLink = value;
              debugPrint(downloadLink);
            });
            print("Upload was successful");
            break;
        }
      });
    } catch (e) {
      debugPrint('error occured');
    }
    return downloadLink;
  }
}
