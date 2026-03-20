import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationService {
  const NotificationService();

  Future<void> scheduleLocalReminder({
    required String id,
    required String title,
    required String body,
    required DateTime when,
  }) async {
    // Stub for local notifications wiring (Android-first implementation later).
  }
}

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return const NotificationService();
});
