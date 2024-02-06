class User {
  String createDate;
  String createdBy;
  String modifyDate;
  String modifiedBy;
  int id;
  String? gender;
  String username;
  bool accountNonExpired;
  bool accountNonLocked;
  bool active;
  bool credentialsNonExpired;
  String email;
  String? phone;
  bool justCreated;
  int? lastLoginFailures;
  String? lastLoginTime;
  int? totalLoginFailures;
  String? orgId;
  List<String> roles;
  List<String> authorities;

  User({
    required this.createDate,
    required this.createdBy,
    required this.modifyDate,
    required this.modifiedBy,
    required this.id,
    this.gender,
    required this.username,
    required this.accountNonExpired,
    required this.accountNonLocked,
    required this.active,
    required this.credentialsNonExpired,
    required this.email,
    this.phone,
    required this.justCreated,
    this.lastLoginFailures,
    this.lastLoginTime,
    this.totalLoginFailures,
    this.orgId,
    required this.roles,
    required this.authorities,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      createDate: json['createDate'],
      createdBy: json['createdBy'],
      modifyDate: json['modifyDate'],
      modifiedBy: json['modifiedBy'],
      id: json['id'],
      gender: json['gender'],
      username: json['username'],
      accountNonExpired: json['accountNonExpired'],
      accountNonLocked: json['accountNonLocked'],
      active: json['active'],
      credentialsNonExpired: json['credentialsNonExpired'],
      email: json['email'],
      phone: json['phone'],
      justCreated: json['justCreated'],
      lastLoginFailures: json['lastLoginFailures'],
      lastLoginTime: json['lastLoginTime'],
      totalLoginFailures: json['totalLoginFailures'],
      orgId: json['orgId'],
      roles: List<String>.from(json['roles']),
      authorities: List<String>.from(json['authorities']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createDate': createDate,
      'createdBy': createdBy,
      'modifyDate': modifyDate,
      'modifiedBy': modifiedBy,
      'id': id,
      'gender': gender,
      'username': username,
      'accountNonExpired': accountNonExpired,
      'accountNonLocked': accountNonLocked,
      'active': active,
      'credentialsNonExpired': credentialsNonExpired,
      'email': email,
      'phone': phone,
      'justCreated': justCreated,
      'lastLoginFailures': lastLoginFailures,
      'lastLoginTime': lastLoginTime,
      'totalLoginFailures': totalLoginFailures,
      'orgId': orgId,
      'roles': roles,
      'authorities': authorities,
    };
  }
}
