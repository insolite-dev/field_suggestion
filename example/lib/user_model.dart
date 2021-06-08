class UserModel {
  final String? email;
  final String? password;

  const UserModel({this.email, this.password});

  // If we wanna use this model class into FieldSuggestion.
  // Then we must to have toJson method, like this:
  Map<String, dynamic> toJson() => {
        'email': this.email,
        'password': this.password,
      };
}
