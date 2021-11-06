//Stores account information
class Account {
  final String username;
  final String email;
  final String password;

  Account(this.username, this.email, this.password);

  //Converts account to map format
  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "email": email,
      "password": password,
    };
  }

  //Converts account to string format
  @override
  String toString() {
    return "Student $username with email $email";
  }
}
