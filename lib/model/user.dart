import 'dart:convert';

User welcomeFromJson(String str) => User.fromJson(json.decode(str));

String welcomeToJson(User data) => json.encode(data.toJson());

class User {
    User({
        required this.username,
        required this.password,
    });

    String username;
    String password;

    factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
    };
}


