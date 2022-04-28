class User {
  String firstName;
  String lastName;
  String email;
  String alamat;
  String password;
  
  User(this.firstName,this.lastName,this.alamat,this.email,this.password);
  
  Map toJson()=>{
    'firstName':this.firstName,
    'lastName':this.lastName,
    'email':this.email,
    'alamat':this.alamat,
    'password':this.password,
  };

  User.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'], 
        email = json['email'], 
        alamat=json['alamat'],
        password=json['password'];
}