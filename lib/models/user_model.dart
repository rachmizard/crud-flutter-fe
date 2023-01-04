class UserModel {
  final int id;
  final String name;
  final String email;
  final String updatedAt;
  final String createdAt;
  final int iat;
  final int exp;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.updatedAt,
    required this.createdAt,
    required this.iat,
    required this.exp,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
      iat: json['iat'],
      exp: json['exp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
      'iat': iat,
      'exp': exp,
    };
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, updatedAt: $updatedAt, createdAt: $createdAt, iat: $iat, exp: $exp)';
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? updatedAt,
    String? createdAt,
    int? iat,
    int? exp,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      iat: iat ?? this.iat,
      exp: exp ?? this.exp,
    );
  }
}
