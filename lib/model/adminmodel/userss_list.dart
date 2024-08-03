class adminmodel {
  final String uid;
  final String email;
  final String displayName;
  final String photoURL;

  adminmodel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoURL,
  });

  // Convert a UserModel instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
    };
  }

  // Convert a Map to a UserModel instance
  factory adminmodel.fromMap(Map<String, dynamic> map) {
    return adminmodel(
      uid: map['uid'],
      email: map['email'],
      displayName: map['displayName'],
      photoURL: map['photoURL'],
    );
  }
}
