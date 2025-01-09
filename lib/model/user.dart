import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String email;
  final String name;
  final String phone;
  final bool status;
  final int timestamp;




  const Users(
      {required this.name,
        required this.status,
        required this.email,
        required this.phone,
        required this.timestamp,
      });

  static Users fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Users(
      name: snapshot["name"],
      status: snapshot["status"],
      email: snapshot["email"],
      phone: snapshot["phone"],
      timestamp: snapshot["timestamp"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "status": status,
    "phone": phone,
    "timestamp": timestamp,
  };
}