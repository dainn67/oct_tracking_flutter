class TokenUser {
  late String userName;
  late List<String> scope;
  late bool active;
  late int exp;
  late TokenUserDetail user;
  late List<String> authorities;
  late String jti;
  late String clientId;

  TokenUser({
    required this.userName,
    required this.scope,
    required this.active,
    required this.exp,
    required this.user,
    required this.authorities,
    required this.jti,
    required this.clientId,
  });

  // Factory method to create User instance from JSON
  factory TokenUser.fromJson(Map<String, dynamic> json) {
    return TokenUser(
      userName: json['user_name'],
      scope: List<String>.from(json['scope']),
      active: json['active'],
      exp: json['exp'],
      user: TokenUserDetail.fromJson(json['user']),
      authorities: List<String>.from(json['authorities']),
      jti: json['jti'],
      clientId: json['client_id'],
    );
  }
}

class TokenUserDetail {
  late String createDate;
  late String createdBy;
  late String modifyDate;
  late String modifiedBy;
  late int id;
  // Other properties ...

  TokenUserDetail({
    required this.createDate,
    required this.createdBy,
    required this.modifyDate,
    required this.modifiedBy,
    required this.id,
    // Other properties ...
  });

  // Factory method to create UserDetail instance from JSON
  factory TokenUserDetail.fromJson(Map<String, dynamic> json) {
    return TokenUserDetail(
      createDate: json['createDate'],
      createdBy: json['createdBy'],
      modifyDate: json['modifyDate'],
      modifiedBy: json['modifiedBy'],
      id: json['id'],
      // Other properties ...
    );
  }
}
