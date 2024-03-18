class UserSession {
  static final UserSession _instance = UserSession._internal();

  int userId = 0;
  String name = '';

  UserSession._internal();

  factory UserSession() {
    return _instance;
  }

  // Phương thức để cập nhật userId
  void setUserId(int id) {
    userId = id;
  }

  // Phương thức để cập nhật tên
  void setName(String name) {
    this.name = name;
  }

  // Phương thức để lấy userId
  int getUserId() {
    return userId;
  }

  // Phương thức để lấy tên
  String getName() {
    return name;
  }
}