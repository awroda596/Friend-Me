


class user {
  final String username;
  final String email;
  final String first_name;
  final String last_name;
  final String password;


  user({required this.username, required this.email, required this.first_name, required this.last_name, required this.password});

  factory user.fromJson(Map<String, dynamic> json) {
    return user(
      username: json['username'],
      email: json['email'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
    'username' : username,
    'first_name': first_name,
    'last_name': last_name,
    'password': password,
    'email': email,
  };
}