class Account {
  final String firstName;
  final String lastName;
  final String accessToken;
  final String refreshToken;

  Account({
    required this.firstName,
    required this.lastName,
    required this.accessToken,
    required this.refreshToken,
  });

  factory Account.fromMap(Map<String, dynamic> json) => Account(
        firstName: json["first_name"],
        lastName: json["last_name"],
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toMap() => {
        "first_name": firstName,
        "last_name": lastName,
        "access_token": accessToken,
        "refresh_token": refreshToken,
      };
}
