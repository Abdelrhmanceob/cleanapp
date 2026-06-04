import 'package:flutter/material.dart';
import '../../core/admin_layout.dart';
import '../../core/admin_scope.dart';
import '../../core/admin_store.dart';
import '../../core/theme.dart';

class WorkersPage extends StatefulWidget {
  const WorkersPage({super.key});

  @override
  State<WorkersPage> createState() => _WorkersPageState();
}

class _WorkersPageState extends State<WorkersPage> {
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _specCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _specCtrl.dispose();
    super.dispose();
  }

  void _showAddDialog(AdminStore store) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('إضافة عامل'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _nameCtrl, decoration: const InputDecoration(labelText: 'الاسم')),
            TextField(controller: _phoneCtrl, decoration: const InputDecoration(labelText: 'الهاتف')),
            TextField(controller: _specCtrl, decoration: const InputDecoration(labelText: 'التخصص')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
          FilledButton(
            onPressed: () {
              if (_nameCtrl.text.trim().isEmpty) return;
              store.addWorker(
                name: _nameCtrl.text.trim(),
                phone: _phoneCtrl.text.trim(),
                specialty: _specCtrl.text.trim().isEmpty ? 'تنظيف عام' : _specCtrl.text.trim(),
              );
              _nameCtrl.clear();
              _phoneCtrl.clear();
              _specCtrl.clear();
              Navigator.pop(ctx);
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = AdminScope.of(context);
    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final mobile = AdminLayout.isMobile(context);
        return SingleChildScrollView(
          padding: AdminLayout.pagePadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (mobile) ...[
                Text(
                  '${store.workers.length} عامل مسجّل',
                  style: const TextStyle(fontSize: 16, color: AppTheme.textMuted),
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: () => _showAddDialog(store),
                  icon: const Icon(Icons.add),
                  label: const Text('إضافة عامل'),
                  style: FilledButton.styleFrom(backgroundColor: AppTheme.primaryGold),
                ),
              ] else
                Row(
                  children: [
                    Text(
                      '${store.workers.length} عامل مسجّل',
                      style: const TextStyle(fontSize: 16, color: AppTheme.textMuted),
                    ),
                    const Spacer(),
                    FilledButton.icon(
                      onPressed: () => _showAddDialog(store),
                      icon: const Icon(Icons.add),
                      label: const Text('إضافة عامل'),
                      style: FilledButton.styleFrom(backgroundColor: AppTheme.primaryGold),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              ...store.workers.map((w) => _WorkerCard(worker: w, store: store)),
            ],
          ),
        );
      },
    );
  }
}

class _WorkerCard extends StatelessWidget {
  final WorkerModel worker;
  final AdminStore store;
  const _WorkerCard({required this.worker, required this.store});

  @override
  Widget build(BuildContext context) {
    final mobile = AdminLayout.isMobile(context);
    final avatar = CircleAvatar(
      backgroundColor: worker.active ? AppTheme.primaryGold : Colors.grey.shade300,
      child: Text(
        worker.name.isNotEmpty ? worker.name[0] : '?',
        style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textDark),
      ),
    );
    final info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(worker.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        Text(worker.specialty, style: const TextStyle(color: AppTheme.textMuted, fontSize: 13)),
        Text(worker.phone, style: const TextStyle(color: AppTheme.textMuted, fontSize: 12)),
      ],
    );
    final statusChip = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: (worker.active ? const Color(0xFF2D8E5B) : AppTheme.textMuted).withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        worker.active ? 'نشط' : 'غير نشط',
        style: TextStyle(
          color: worker.active ? const Color(0xFF2D8E5B) : AppTheme.textMuted,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
    final toggle = Switch(
      value: worker.active,
      activeColor: AppTheme.primaryGold,
      onChanged: (_) => store.toggleWorkerActive(worker.id),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderSubtle),
      ),
      child: mobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    avatar,
                    const SizedBox(width: 16),
                    Expanded(child: info),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [statusChip, toggle],
                ),
              ],
            )
          : Row(
              children: [
                avatar,
                const SizedBox(width: 16),
                Expanded(child: info),
                toggle,
                const SizedBox(width: 8),
                statusChip,
              ],
            ),
    );
  }
}
