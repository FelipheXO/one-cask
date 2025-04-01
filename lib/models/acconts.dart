class Accounts {
  String? email;
  String? password;

  Accounts({this.email, this.password});

  Accounts.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
