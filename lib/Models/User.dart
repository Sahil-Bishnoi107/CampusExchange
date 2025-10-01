class UserModel {
  final String userId;
  final String username;
  final String email;
  final String? profilePic;
  final String? address;
  final String? phone;
  final String? university;

  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    this.profilePic,
    this.address,
    this.phone,
    this.university,
  });

  // From JSON (for API responses)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      username: json['username'],
      email: json['email'],
      profilePic: json['profilepic'],
      address: json['address'],
      phone: json['phone'],
      university: json['university'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'email': email,
      'profilepic': profilePic,
      'address': address,
      'phone': phone,
      'university': university,
    };
  }
}
