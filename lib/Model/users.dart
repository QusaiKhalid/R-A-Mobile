class User {
    int? id;
    String? name;
    String? password;
    String? type;
    int? companyid; 
    //Named parameter
    User ({this.id, this.password, this.name, this.type, this.companyid});
    //Named constructor
    User.onlyEmail  ({this.id, this.password });
    Map <String,dynamic> tomap(){
      return {'id':id, 'password':password, 'name':name, 'type':type, 'companyid':companyid};
    }

}