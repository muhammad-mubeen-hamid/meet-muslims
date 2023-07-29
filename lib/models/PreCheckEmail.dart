class PreCheckEmailResponse {
  String? _username;
  String? _userCreateDate;
  bool? _enabled;
  String? _userStatus;

  PreCheckEmailResponse(
      {String? username,
        String? userCreateDate,
        bool? enabled,
        String? userStatus}) {
    if (username != null) {
      this._username = username;
    }
    if (userCreateDate != null) {
      this._userCreateDate = userCreateDate;
    }
    if (enabled != null) {
      this._enabled = enabled;
    }
    if (userStatus != null) {
      this._userStatus = userStatus;
    }
  }

  String? get username => _username;
  set username(String? username) => _username = username;
  String? get userCreateDate => _userCreateDate;
  set userCreateDate(String? userCreateDate) =>
      _userCreateDate = userCreateDate;
  bool? get enabled => _enabled;
  set enabled(bool? enabled) => _enabled = enabled;
  String? get userStatus => _userStatus;
  set userStatus(String? userStatus) => _userStatus = userStatus;

  PreCheckEmailResponse.fromJson(Map<String, dynamic> json) {
    _username = json['username'];
    _userCreateDate = json['userCreateDate'];
    _enabled = json['enabled'];
    _userStatus = json['userStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this._username;
    data['userCreateDate'] = this._userCreateDate;
    data['enabled'] = this._enabled;
    data['userStatus'] = this._userStatus;
    return data;
  }
}