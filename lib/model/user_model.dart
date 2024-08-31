class UserModel {
  final String uid;
  final String email;
  final String Username;
  final String photoURL;

  UserModel({
    required this.uid,
    required this.email,
    required this.Username,
    required this.photoURL,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': Username,
      'photoURL': photoURL,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      Username: map['username'] ?? '',
      photoURL: map['photoURL'] ?? '',
    );
  }
}
