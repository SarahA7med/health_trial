class UserData {
  // Private constructor
  UserData._privateConstructor();

  // The single instance of UserData
  static final UserData _instance = UserData._privateConstructor();

  // Factory constructor returns the same instance
  factory UserData() {
    return _instance;
  }

  // Data fields
  String? id = '';
  String name = '';
  int age = 0;
  double weight = 0.0;
  double height = 0.0;
  String gender = '';
}