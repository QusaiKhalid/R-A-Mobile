import 'package:flutter/material.dart';
import 'package:qusai_final_project/Controller/db_controller.dart';
import 'package:qusai_final_project/Model/users.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}
List<String> options= ['Pilot', 'Engineer', 'Admin'];
class _AddUserState extends State<AddUser> {
  String currentOption = options[0];
  TextEditingController nameController =TextEditingController();
  TextEditingController idController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  DBcontroller dbc = DBcontroller();
  final _key = GlobalKey<FormState>();
  String? validatePassword(String? value) {
    RegExp regex =RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value!.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('USERS'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal:30, vertical: 60),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    validator:(value) {
                      if(value!.isEmpty) return 'Must enter Name';
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'User name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder()
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: idController,
                    validator:(value) {
                      if(value!.isEmpty) return 'Must enter an ID';
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'ID',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder()
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: passwordController,
                    validator:validatePassword,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder()
                    ),
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 12,
                  ),
                  RadioListTile(
                    title: const Text('Pilot'),
                    value: options[0],
                    groupValue: currentOption,
                    onChanged: ((value) {
                      setState(() {
                        currentOption = value.toString();
                      });
                    })
                  ),
                  RadioListTile(
                    title: const Text('Engineer'),
                    value: options[1],
                    groupValue: currentOption,
                    onChanged: ((value) {
                      setState(() {
                        currentOption = value.toString();
                      });
                    })
                  ),
                  RadioListTile(
                    title: const Text('Admin'),
                    value: options[2],
                    groupValue: currentOption,
                    onChanged: ((value) {
                      setState(() {
                        currentOption = value.toString();
                      });
                    })
                  ),
                  ElevatedButton(
                    onPressed: (){
                      
                      if(_key.currentState!.validate())
                      {
                        _key.currentState!.save();
                        dbc.insertUser(
                          User(
                            name: nameController.text,
                            password: passwordController.text,
                            type: currentOption,
                            companyid: int.parse(idController.text),
                          )
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Add')
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}