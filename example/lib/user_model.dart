class UserModel {
  final String? email;
  final String? username;
  final String? password;

  const UserModel({this.email, this.username, this.password});

  // If we wanna use this model class into FieldSuggestion.
  // Then we must to have toJson method, like this:
  Map<String, dynamic> toJson() => {
        'email': this.email,
        'username': this.username,
        'password': this.password,
      };
}
