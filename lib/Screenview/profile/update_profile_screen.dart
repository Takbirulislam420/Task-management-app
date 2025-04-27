import 'dart:convert';
import 'dart:io'; // Import this for File class
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_management_app/Screenview/Components/app_bar_component.dart';
import 'package:task_management_app/Screenview/Components/background_component.dart';
import 'package:task_management_app/Screenview/Components/show_snackbar.dart';
import 'package:task_management_app/controller/onboarding_controller/auth_controller.dart';
import 'package:task_management_app/const/app_int.dart';
import 'package:task_management_app/const/app_string.dart';
import 'package:task_management_app/controller/profile_controller/update_profile_controller.dart';
import '../../data/model/user_model.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final UpdateProfileController _updateProfileController =
      Get.find<UpdateProfileController>();

  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;

  @override
  void initState() {
    UserModel userModel = AuthController.to.userModel!;
    _emailController.text = userModel.email;
    _fnameController.text = userModel.firstName;
    _lnameController.text = userModel.lastName;
    _phoneController.text = userModel.mobile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        fromProfileUpdate: true,
      ),
      body: BackgroundComponent(
        child: Container(
          alignment: Alignment.center,
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formkey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(AppInt.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppString.updateProfile,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 25),
                    _photoPicker(),
                    SizedBox(height: 10),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: "Email",
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      controller: _fnameController,
                      decoration: InputDecoration(
                        hintText: "First name",
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your first name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      controller: _lnameController,
                      decoration: InputDecoration(
                        hintText: "Last name",
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your last name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      controller: _phoneController,
                      decoration: InputDecoration(
                        hintText: "Mobile",
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                      ),
                    ),
                    SizedBox(height: 15),
                    GetBuilder<UpdateProfileController>(builder: (controller) {
                      return Visibility(
                        visible: controller.updateProfileInProgress == false,
                        replacement: Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                          onPressed: _ontapSubmitButton,
                          child: Text(AppString.submit),
                        ),
                      );
                    }),
                    SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapPhotoPicker() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _pickedImage = image;
      setState(() {});
    }
  }

  Widget _photoPicker() {
    return GestureDetector(
      onTap: _onTapPhotoPicker,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: Text("Photo"),
            ),
            SizedBox(width: 5),
            _pickedImage != null
                ? Image.memory(
                    // Directly use the bytes of the selected image
                    File(_pickedImage!.path).readAsBytesSync(),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                : Text("Select your picture"),
          ],
        ),
      ),
    );
  }

  void _ontapSubmitButton() {
    _updateUser();
  }

  Future<void> _updateUser() async {
    Map<String, dynamic> requestBody = {};

    // Only add fields if they are not empty
    if (_emailController.text.trim().isNotEmpty) {
      requestBody["email"] = _emailController.text.trim();
    }

    if (_fnameController.text.trim().isNotEmpty) {
      requestBody["firstName"] = _fnameController.text.trim();
    }

    if (_lnameController.text.trim().isNotEmpty) {
      requestBody["lastName"] = _lnameController.text.trim();
    }

    if (_phoneController.text.trim().isNotEmpty) {
      requestBody["mobile"] = _phoneController.text.trim();
    }

    if (_passwordController.text.trim().isNotEmpty) {
      requestBody["password"] = _passwordController.text.trim();
    }

    if (_pickedImage != null) {
      List<int> imageBytes = await _pickedImage!.readAsBytes();
      String encodeImage = base64Encode(imageBytes);
      requestBody['photo'] = encodeImage;
    }

    // If requestBody is still empty, no update needed
    if (requestBody.isEmpty) {
      // ignore: use_build_context_synchronously
      showSnackbarMessage(context, "No changes made", true);
      return;
    }

    final bool isSuccess =
        await _updateProfileController.getUpdateProfile(requestBody);

    if (isSuccess) {
      _passwordController.clear();

      // Update locally if changed
      UserModel updatedUserModel = UserModel(
        email: requestBody["email"] ?? AuthController.to.userModel!.email,
        firstName:
            requestBody["firstName"] ?? AuthController.to.userModel!.firstName,
        lastName:
            requestBody["lastName"] ?? AuthController.to.userModel!.lastName,
        mobile: requestBody["mobile"] ?? AuthController.to.userModel!.mobile,
        photo: requestBody["photo"] ?? AuthController.to.userModel!.photo,
      );

      await AuthController.to
          .saveUserInformation(AuthController.to.token!, updatedUserModel);

      // Update user model in memory
      AuthController.to.userModel = updatedUserModel;

      // ignore: use_build_context_synchronously
      showSnackbarMessage(context, "Your profile updated successfully");

      // Go back to the previous screen
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } else {
      // ignore: use_build_context_synchronously
      showSnackbarMessage(context,
          _updateProfileController.errorMessage ?? "Update failed", true);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _fnameController.dispose();
    _lnameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
