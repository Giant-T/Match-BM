class UserModel {
  static String collection = "user";
  String email;
  String firstname;
  String lastname;

  UserModel(this.email, this.firstname, this.lastname);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
    };
  }
}
