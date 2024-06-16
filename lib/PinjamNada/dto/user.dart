class User {
  String roles;
  int userID;
  String username;
  String? email;
  String? full_name;
  String? phone;
  String? profile_picture;

  User({
    required this.roles,
    required this.userID,
    required this.username,
    this.email,
    this.full_name,
    this.phone,
    this.profile_picture,
  });

  // Factory constructor to create a User object from a JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      roles: json['roles'],
      userID: json['userID'],
      username: json['username'],
      email: json['email'],
      full_name: json['full_name'],
      phone: json['phone'],
      profile_picture: json['profile_picture'],
    );
  }

  // Method to convert a User object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'roles': roles,
      'userID': userID,
      'username': username,
      'email': email,
      'full_name': full_name,
      'phone': phone,
      'profile_picture': profile_picture,
    };
  }

  @override
  String toString() {
    return 'User{roles: $roles, userID: $userID, username: $username, email: $email, full_name: $full_name, phone: $phone, profile_picture: $profile_picture}';
  }
}
