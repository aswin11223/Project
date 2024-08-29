import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_8/services/notifiaction_service.dart';


class NotificationProvider with ChangeNotifier {
  final NotificationService _notificationService = NotificationService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _notifications = [];

  List<DocumentSnapshot> get notifications => _notifications;

  void fetchNotifications(String userId) {
    _notificationService.getNotifications(userId).listen((snapshot) {
      _notifications = snapshot.docs;
      notifyListeners();
    });
  }
  Future<void> clearnotification(String notificationId) async {
    await _firestore.collection('notifications').doc(notificationId).delete();
    _notifications.removeWhere((doc) => doc.id == notificationId);
    notifyListeners();
  }
}
