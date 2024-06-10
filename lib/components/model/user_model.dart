

class UserModel{
  final String? id;
 // String email;
  //String password;
  final String firstName;
  final String lastName;
  final String phoneNo;
  final String address;
  
  const UserModel({
    this.id,
    //required this.email,
    //required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNo,
    required this.address,
  });

  toJson(){
    return {
      //"Email": email,
      //"Password": password,
      "First Name": firstName,
      "Last Name": lastName,
      "Phone Number": phoneNo,
      "Address": address, 
    };
  }
}