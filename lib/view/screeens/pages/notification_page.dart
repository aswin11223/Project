import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/provider/notification_provider.dart';
import 'package:provider/provider.dart';


class NotificationsPage extends StatelessWidget {
  final String userId;

  NotificationsPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    Provider.of<NotificationProvider>(context, listen: false).fetchNotifications(userId);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Notifications', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, notificationProvider, child) {
          final notifications = notificationProvider.notifications;

          if (notifications.isEmpty) {
            return Center(child: Text('No notifications'));
          }

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              final data = notification.data() as Map<String, dynamic>;
              final message = data['message'] ?? 'No Message';
              final timestamp = data['timestamp'] != null
                  ? (data['timestamp'] as Timestamp).toDate().toString()
                  : 'No Timestamp';

              return ListTile(
                title: Text(message),
                subtitle: Text(timestamp),
              );
            },
          );
        },
      ),
    );
  }
}
