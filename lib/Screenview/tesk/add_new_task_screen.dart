import 'package:flutter/material.dart';
import 'package:task_management_app/Screenview/Components/app_bar_component.dart';
import 'package:task_management_app/Screenview/Components/background_component.dart';
import 'package:task_management_app/Screenview/Components/center_circular_progress_indecator.dart';
import 'package:task_management_app/Screenview/Components/show_snackbar.dart';
import 'package:task_management_app/const/app_int.dart';
import 'package:task_management_app/const/app_string.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/utils/api_urls.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _addTaskInPregree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(),
      body: BackgroundComponent(
          child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: AppInt.padding, right: AppInt.padding),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppString.addNewTask,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _titleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    //labelText: 'Email',
                    hintText: AppString.title,
                  ),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter a title here";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: _descriptionController,
                  maxLines: 7,
                  //textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      hintText: AppString.description,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8)),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter a discription here";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Visibility(
                  visible: _addTaskInPregree == false,
                  replacement: CenterCircularProgressIndecator(),
                  child: ElevatedButton(
                      onPressed: _ontapSubmitButton,
                      child: Text(AppString.submit)),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  void _ontapSubmitButton() {
    if (_formkey.currentState!.validate()) {
      _addTask();
    }
    // Navigator.pushAndRemoveUntil(context,
    //     MaterialPageRoute(builder: (context) => HomeScreen()), (pre) => false);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => HomeScreen()),
    // );
  }

  Future<void> _addTask() async {
    _addTaskInPregree = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "title": _titleController.text,
      "description": _descriptionController.text,
      "status": "New"
    };

    NetworkResponse response = await NetworkClient.postRequest(
        url: ApiUrls.createTaskUrl, body: requestBody);
    _addTaskInPregree = false;
    setState(() {});
    if (response.isSuccess) {
      _clearTextFields();
      // ignore: use_build_context_synchronously
      showSnackbarMessage(context, "create task successfull");
    } else {
      // ignore: use_build_context_synchronously
      showSnackbarMessage(context, response.errorMessage, true);
    }
  }

  void _clearTextFields() {
    _titleController.clear();
    _descriptionController.clear();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
