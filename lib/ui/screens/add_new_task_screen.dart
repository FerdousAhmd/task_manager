import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController _titleTEController = TextEditingController();
TextEditingController _descriptionTEController = TextEditingController();
bool _addNewTaskInProgress = false;

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 42,
                ),
                Text(
                  'Add New Task',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                    controller: _titleTEController,
                    decoration: const InputDecoration(
                        hintText: 'Title'),
                    validator: (String? value) {
                      if (value
                          ?.trim()
                          .isEmpty ?? true) {
                        return 'Enter a value';
                      }
                      else {
                        return null;
                      }
                    }
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 5,
                    decoration: InputDecoration(hintText: 'Description'),
                    validator: (String? value) {
                      if (value
                          ?.trim()
                          .isEmpty ?? true) {
                        return 'Enter a value';
                      }
                      else {
                        return null;
                      }
                    }
                ),
                const SizedBox(
                  height: 16,
                ),
                Visibility(
                  visible: !_addNewTaskInProgress,
                  replacement: const CircularProgressIndicator(),
                  child: ElevatedButton(
                      onPressed: _onTapSubmitButton,
                      child: Icon(Icons.arrow_forward_ios)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate());
    _addNewTask();
  }

  Future<void> _addNewTask() async {
    setState(() {});
    Map<String, dynamic> requestBody = {
      'title': _titleTEController.text.trim(),
      'description': _descriptionTEController.text.trim(),
      'Status': 'New',
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
        url: urls.addNewTask, body: requestBody);
    _addNewTaskInProgress = false;
    setState(() {});
    if(response.isSuccess) {
      showSnackBarMessage(context, 'New Task Added');
    }
    else{
      showSnackBarMessage(context, response.errorMessage);
    }
  }
  void _clearTextFields(){
    _titleTEController.clear();
    _descriptionTEController.clear();
}
}
