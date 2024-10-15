class Users {
  //  لوطلا
  int age; //  رمعلا
  // سنجلا ( ركذ / ىثنأ )
  String email;
  String gender;
  double height;

  String name;
  String profilePicture;
  String token;
  double weight;

  Users({
    required this.age,
    required this.email,
    required this.gender,
    required this.height,
    required this.name,
    required this.profilePicture,
    required this.token,
    required this.weight,
  });

  Map<String, dynamic> toMap() {
    return {
      'age': age,
      'email': email,
      'gender': gender,
      'height': height,
      'name':name,
      'profilePicture':profilePicture,
      'token': token,
      'weight':weight,

      //  سنجلا ةفاضإ
    };
  }

  static Users fromMap(Map<String, dynamic> map) {
    return Users(
      age: map['age'],
     email: map['email'],
      gender: map['gender'],
      height: map['height'],
     name: map['name'],
      profilePicture: map['profilePicture'],
      token: map['token'],
    weight: map['weight'],
      //  سنجلا ةفاضإ
    );
  }
}