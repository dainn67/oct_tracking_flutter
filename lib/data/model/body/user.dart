class UserBody {
  String username;
  String displayName;
  String email;
  int gender;
  List<String> roles;
  String password;
  bool active;
  bool justCreated;
  bool accountNonLocked;
  bool accountNonExpired;
  bool credentialsNonExpired;
  String confirmPassword;

  UserBody({
    required this.username,
    required this.displayName,
    required this.email,
    required this.gender,
    required this.roles,
    required this.password,
    required this.active,
    required this.justCreated,
    required this.accountNonLocked,
    required this.accountNonExpired,
    required this.credentialsNonExpired,
    required this.confirmPassword,
  });

  factory UserBody.fromJson(Map<String, dynamic> json) {
    return UserBody(
      username: json['username'] ?? '',
      displayName: json['displayName'] ?? '',
      email: json['email'] ?? '',
      gender: json['gender'] ?? 0,
      roles: List<String>.from(json['roles'] ?? []),
      password: json['password'] ?? '',
      active: json['active'] ?? false,
      justCreated: json['justCreated'] ?? false,
      accountNonLocked: json['accountNonLocked'] ?? false,
      accountNonExpired: json['accountNonExpired'] ?? false,
      credentialsNonExpired: json['credentialsNonExpired'] ?? false,
      confirmPassword: json['confirmPassword'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'displayName': displayName,
      'email': email,
      'gender': gender,
      'roles': roles,
      'password': password,
      'active': active,
      'justCreated': justCreated,
      'accountNonLocked': accountNonLocked,
      'accountNonExpired': accountNonExpired,
      'credentialsNonExpired': credentialsNonExpired,
      'confirmPassword': confirmPassword,
    };
  }
}
