import 'package:flutter/material.dart';
import '../../core/admin_layout.dart';
import '../../core/theme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notifyOrders = true;
  bool _autoAssign = false;
  String _language = 'ar';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AdminLayout.pagePadding(context),
      child: Container(
        padding: EdgeInsets.all(AdminLayout.isMobile(context) ? 16 : 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.borderSubtle),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('إعدادات النظام', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('إشعار عند طلب جديد'),
              value: _notifyOrders,
              activeColor: AppTheme.primaryGold,
              onChanged: (v) => setState(() => _notifyOrders = v),
            ),
            SwitchListTile(
              title: const Text('تعيين عامل تلقائي'),
              value: _autoAssign,
              activeColor: AppTheme.primaryGold,
              onChanged: (v) => setState(() => _autoAssign = v),
            ),
            ListTile(
              title: const Text('اللغة'),
              trailing: DropdownButton<String>(
                value: _language,
                items: const [
                  DropdownMenuItem(value: 'ar', child: Text('العربية')),
                  DropdownMenuItem(value: 'en', child: Text('English')),
                ],
                onChanged: (v) => setState(() => _language = v ?? 'ar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
