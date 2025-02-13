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
  DateTime? lastLoginTime;
  int? totalLoginFailures;
  dynamic orgId;
  List<String>? roles;
  List<String>? authorities;

  User({
    required this.createDate,
    required this.createdBy,
    required this.modifyDate,
    required this.modifiedBy,
    required this.id,
    required this.gender,
    required this.username,
    required this.accountNonExpired,
    required this.accountNonLocked,
    required this.active,
    required this.credentialsNonExpired,
    required this.email,
    required this.phone,
    required this.justCreated,
    required this.lastLoginFailures,
    required this.lastLoginTime,
    required this.totalLoginFailures,
    required this.orgId,
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
      lastLoginTime: json['lastLoginTime'] != null
          ? DateTime.parse(json['lastLoginTime'])
          : null,
      totalLoginFailures: json['totalLoginFailures'],
      orgId: json['orgId'],
      roles:
      (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      authorities: (json['authorities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }
}
