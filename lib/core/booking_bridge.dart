import 'dart:convert';
import 'admin_store.dart';

typedef BookingReader = Map<String, dynamic>? Function();

BookingReader _reader = _stubReader;

Map<String, dynamic>? _stubReader() => null;

void registerBookingReader(BookingReader reader) {
  _reader = reader;
}

void applyPendingBooking(AdminStore store) {
  final data = _reader();
  if (data == null) return;
  store.addOrderFromBooking(
    client: data['name']?.toString() ?? 'عميل',
    phone: data['phone']?.toString() ?? '',
    service: data['service']?.toString() ?? 'باقة أساسية',
    notes: data['notes']?.toString() ?? '',
  );
}

/// Parse JSON saved from the landing booking form (web).
Map<String, dynamic>? parseBookingJson(String raw) {
  try {
    final decoded = jsonDecode(raw);
    if (decoded is Map<String, dynamic>) return decoded;
    if (decoded is Map) return Map<String, dynamic>.from(decoded);
  } catch (_) {}
  return null;
}
