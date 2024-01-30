class TokenResponsive {
  String? accessToken;
  String? tokenType;
  String? refreshToken;
  int? expiresIn;
  String? scope;
  String? jti;

  TokenResponsive(
      {this.accessToken,
      this.tokenType,
      this.refreshToken,
      this.expiresIn,
      this.scope,
      this.jti});

  TokenResponsive.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    refreshToken = json['refresh_token'];
    expiresIn = json['expires_in'];
    scope = json['scope'];
    jti = json['jti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['refresh_token'] = refreshToken;
    data['expires_in'] = expiresIn;
    data['scope'] = scope;
    data['jti'] = jti;
    return data;
  }
}
