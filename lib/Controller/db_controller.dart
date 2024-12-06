import 'package:sqflite/sqflite.dart';
import '../Model/users.dart';
class DBcontroller{
  /*
  1. Create the data base itself.
  2. Create the table.
  3. Create the CRUD {Create, Read, Update, Delete}.
  4. Create the Queries.
  */

  //1.
  static Future<Database> initiateDB(){
    return openDatabase(
      'University',
      version: 7,
      onCreate: (Database db, int version) async{
        await createdb(db);
      },
    );
  }

  //2.
  static Future<void> createdb(Database db) async{
    await db.execute(
      '''
      CREATE TABLE User(
        id INTEGER PRIMARY KEY,
        name TEXT,
        password TEXT,
        type TEXT,
        companyid INTEGER
      )
      '''
    );
  }

  //3.
  Future insertUser(User users) async{
    final db = DBcontroller.initiateDB();
    db.then((dbc) => dbc.insert('User', users.tomap()));
  }

  Future updateUser(User users) async{
    final db = DBcontroller.initiateDB();
    db.then((dbc) => dbc.update('User', users.tomap(), where: "id=?", whereArgs: [users.id]));
  }

  Future deleteUser(int id) async{
    final db = DBcontroller.initiateDB();
    db.then((dbc) => dbc.delete('User', where: "id=?", whereArgs: [id]));
  }

  //4.
  Future<List<Map<String?, dynamic>>> selectUser() async{
    final db = DBcontroller.initiateDB();
    var users = await db.then((dbc) => dbc.query('User'));
    return users;
  }
  Future<String?> getUserTypeById(int id) async {
    // Get a reference to the database
    final db = DBcontroller.initiateDB();

    // Query the database
    List<Map<String, dynamic>> results = await db.then((dbc) => dbc.query(
      'User',
      columns: ['type'],
      where: 'id = ?',
      whereArgs: [id],
    ));

    // Check if any result is found
    if (results.isNotEmpty) {
      // Return the type as a string
      return results.first['type'] as String?;
    } else {
      // Return null if no result found
      return null;
    }
  }

  Future<bool> login(User users) async{
    final db = DBcontroller.initiateDB();
    var result = await db.then((dbc) => dbc.rawQuery("select * from User where id ='${users.id}' AND password = '${users.password}'"));
    if (result.isNotEmpty){
      return true;
      
    }else{
      return false;
      
    }
  }
}