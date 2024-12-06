

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:qusai_final_project/Controller/db_controller.dart';
import 'package:qusai_final_project/add_user.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DBcontroller dbc = DBcontroller();
  List<Map<String?, dynamic>> users = [];

  Future? loadUser() async{
    final userList = await dbc.selectUser();
    setState(() {
      users = userList;
    });
  }
  Future? deleteUser(int id) async{
    setState(() async{
      await dbc.deleteUser(id);
    });
  }
  Widget viewUser(){
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index){
        return Column(
          children: [
            const SizedBox(height: 10,),
            Slidable(
              startActionPane: ActionPane(
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: ((context) {
                      //delete
                    }),
                    backgroundColor: Colors.red,
                    icon: Icons.delete,
                  ),
                  SlidableAction(
                    onPressed: ((context) {
                      deleteUser(users[index]['id']);
                    }),
                    backgroundColor: const Color.fromARGB(251, 255, 243, 134),
                    icon: Icons.edit ,
                  )
                ],
              ),
              child: Container(
                color: Colors.black12,
                child: ListTile(
                  leading: Icon(
                    users[index]['type'] == 'Pilot' ?
                    Icons.airplanemode_active :
                    users[index]['type'] == 'Engineer' ?
                    Icons.engineering:
                    Icons.admin_panel_settings
                    , size: 50,
                  ),
                  title: Text('Name: ${users[index]['name']}'),
                  subtitle: Row(
                    children: [
                      Text('ID: ${users[index]['id'].toString()}'),
                      const SizedBox(width: 10,),
                      Text('Password: ${users[index]['password'].toString()}'),
                    ],
                  ),
                  
                ),
              ),
            ),
            const SizedBox(height: 10,)
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:FutureBuilder(
          future: loadUser(),
          builder: ((context, snapshot) {
            return viewUser();
          }),
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddUser(),));
        },
        child: const Icon(Icons.add),
      ),
    );

  }
}