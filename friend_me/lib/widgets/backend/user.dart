


class User {
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  String password;
  late var auth;


  User({required this.username, required this.email, required this.firstName, required this.lastName, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      password: json['password'],
    );
  }

  void getAuthToken(var token){
    auth = token;
  }

  Map<String, dynamic> toJson() => {
    'username' : username,
    'first_name': firstName,
    'last_name': lastName,
    'password': password,
    'email': email,
  };
}