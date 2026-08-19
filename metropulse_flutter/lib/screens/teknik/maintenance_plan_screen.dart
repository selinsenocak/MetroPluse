import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/common.dart';

enum _TaskStatus { pending, inProgress, completed }

class _Task {
  final String title, desc, team, time;
  final String priorityLabel;
  final Color priorityFg, priorityBg, topBorder;
  _TaskStatus status;
  _Task({
    required this.title,
    required this.desc,
    required this.team,
    required this.time,
    required this.priorityLabel,
    required this.priorityFg,
    required this.priorityBg,
    required this.topBorder,
    this.status = _TaskStatus.pending,
  });
}

class MaintenancePlanScreen extends StatefulWidget {
  const MaintenancePlanScreen({super.key});

  @override
  State<MaintenancePlanScreen> createState() => _MaintenancePlanScreenState();
}

class _MaintenancePlanScreenState extends State<MaintenancePlanScreen> {
  bool _recommendationApplied = false;

  final List<_Task> _tasks = [
    _Task(
      title: 'M1 Hattı Sinyalizasyon Kontrolü',
      desc: 'Kadıköy istasyonu ana sinyal panosu arıza tespiti ve bakımı.',
      team: 'Ekip Alfa',
      time: '08:30 - 10:30',
      priorityLabel: 'YÜKSEK ÖNCELİK',
      priorityFg: MpColors.redDark,
      priorityBg: MpColors.redBg,
      topBorder: MpColors.red,
    ),
    _Task(
      title: 'T3 Yürüyen Merdiven Yağlama',
      desc: 'Moda istasyonu güney çıkışı yürüyen merdiven periyodik mekanik bakımı.',
      team: 'Ekip Beta',
      time: '11:00 - 13:00',
      priorityLabel: 'ORTA ÖNCELİK',
      priorityFg: MpColors.orangeDark,
      priorityBg: MpColors.orangeBg,
      topBorder: MpColors.orange,
    ),
    _Task(
      title: 'İstasyon İçi Aydınlatma Değişimi',
      desc: 'Levent istasyonu peron bölgesi armatür led değişimi.',
      team: 'Ekip Gamma',
      time: '14:00 - 15:30',
      priorityLabel: 'DÜŞÜK ÖNCELİK',
      priorityFg: MpColors.greenDark,
      priorityBg: MpColors.greenBg,
      topBorder: MpColors.green,
    ),
    _Task(
      title: 'Turnike Yazılım Güncellemesi',
      desc: 'Tüm M2 hattı turnikeleri için NFC okuyucu yazılım yaması yüklemesi.',
      team: 'IT Destek',
      time: '07:00 - Devam',
      priorityLabel: 'ORTA ÖNCELİK',
      priorityFg: MpColors.orangeDark,
      priorityBg: MpColors.orangeBg,
      topBorder: MpColors.citizenBlue,
      status: _TaskStatus.inProgress,
    ),
  ];

  void _applyRecommendation() {
    setState(() {
      _recommendationApplied = true;
      _tasks.insert(
        0,
        _Task(
          title: 'M2 Hattı Periyodik Bakımı (Öne Çekildi)',
          desc: 'Yıllık yolculuk verilerine göre en yoğun hat olan M2\'nin periyodik bakımı 1 hafta öne çekildi.',
          team: 'Ekip Alfa',
          time: 'Planlandı: 1 hafta erken',
          priorityLabel: 'ÖNE ÇEKİLDİ',
          priorityFg: MpColors.citizenBlueDark,
          priorityBg: MpColors.lightBlueBg,
          topBorder: MpColors.citizenBlue,
        ),
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('M2 Hattı periyodik bakımı 1 hafta öne çekildi ve plana eklendi.')),
    );
  }

  void _start(_Task task) {
    setState(() => task.status = _TaskStatus.inProgress);
  }

  void _complete(_Task task) {
    setState(() => task.status = _TaskStatus.completed);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('"${task.title}" tamamlandı olarak işaretlendi.')),
    );
  }

  Future<void> _showDetails(_Task task) async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text(task.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: MpColors.textDark)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.desc, style: const TextStyle(fontSize: 13, color: MpColors.textMuted, height: 1.5)),
            const SizedBox(height: 12),
            _detailRow('Zaman', task.time),
            _detailRow('Ekip', task.team),
            _detailRow('Öncelik', task.priorityLabel),
            _detailRow('Durum', _statusLabel(task.status)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Kapat')),
        ],
      ),
    );
  }

  Future<void> _showUpdateDialog(_Task task) async {
    final controller = TextEditingController();
    final note = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Text('Görevi Güncelle', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: MpColors.textDark)),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Güncelleme notu ekleyin (örn: parça bekleniyor)...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Vazgeç')),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            style: ElevatedButton.styleFrom(backgroundColor: MpColors.orange, foregroundColor: Colors.white),
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
    if (note != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(note.trim().isEmpty ? '"${task.title}" güncellendi.' : '"${task.title}" güncellendi: $note')),
      );
    }
  }

  String _statusLabel(_TaskStatus s) => switch (s) {
        _TaskStatus.pending => 'Bekliyor',
        _TaskStatus.inProgress => 'Devam Ediyor',
        _TaskStatus.completed => 'Tamamlandı',
      };

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(width: 70, child: Text(label, style: const TextStyle(fontSize: 12, color: MpColors.textMuted, fontWeight: FontWeight.w600))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 12.5, color: MpColors.textDark, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MpColors.bg,
      appBar: const MpHeader(title: 'MetroPulse', background: MpColors.teknikBlue),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
        children: [
          const Text('Günlük Bakım Planı', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: MpColors.textDark)),
          const SizedBox(height: 4),
          const Text('Teknik Ekip Görev Listesi - 24 Ekim 2023', style: TextStyle(fontSize: 12.5, color: MpColors.textMuted)),
          const SizedBox(height: 16),
          _RecommendationCard(applied: _recommendationApplied, onApply: _applyRecommendation),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.filter_list, size: 16, color: MpColors.textDark),
                label: const Text('Filtrele', style: TextStyle(color: MpColors.textDark, fontWeight: FontWeight.w600, fontSize: 13)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: MpColors.border),
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Yeni görev formu yakında.')));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MpColors.navy,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('+ Yeni Görev', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              ),
            ),
          ]),
          const SizedBox(height: 16),
          for (final task in _tasks) ...[
            _TaskCard(
              task: task,
              onStart: () => _start(task),
              onComplete: () => _complete(task),
              onDetails: () => _showDetails(task),
              onUpdate: () => _showUpdateDialog(task),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  final bool applied;
  final VoidCallback onApply;
  const _RecommendationCard({required this.applied, required this.onApply});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MpColors.lightBlueBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFBFDCF0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: const Icon(Icons.insights, color: MpColors.citizenBlue, size: 16),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text('Bakım Önceliklendirme Önerisi', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: MpColors.citizenBlueDark)),
            ),
          ]),
          const SizedBox(height: 10),
          const Text(
            'Yıllık yolcu verilerine göre, ağdaki tüm istasyonların taşıdığı toplam yolcu sayısı incelendiğinde M2 Hattı (Yenikapı - Hacıosman) Metro İstanbul\'un en yoğun kullanılan hattı olarak öne çıkıyor. Yüksek kullanım riskini azaltmak için bu hattın periyodik bakımının 1 hafta öne çekilmesi öneriliyor.',
            style: TextStyle(fontSize: 12.5, color: Color(0xFF0B3C5D), height: 1.5),
          ),
          const SizedBox(height: 12),
          if (applied)
            Row(children: const [
              Icon(Icons.check_circle, color: MpColors.green, size: 16),
              SizedBox(width: 6),
              Text('Bakım planına eklendi', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: MpColors.greenDark)),
            ])
          else
            SizedBox(
              width: double.infinity,
              child: MpPrimaryButton(label: 'Bakımı 1 Hafta Öne Çek', color: MpColors.citizenBlue, icon: Icons.fast_forward, onTap: onApply),
            ),
        ],
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final _Task task;
  final VoidCallback onStart, onComplete, onDetails, onUpdate;

  const _TaskCard({required this.task, required this.onStart, required this.onComplete, required this.onDetails, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    final isInProgress = task.status == _TaskStatus.inProgress;
    final isCompleted = task.status == _TaskStatus.completed;

    final badgeLabel = isInProgress ? 'DEVAM EDİYOR' : (isCompleted ? 'TAMAMLANDI' : task.priorityLabel);
    final badgeFg = isInProgress ? MpColors.citizenBlueDark : (isCompleted ? MpColors.greenDark : task.priorityFg);
    final badgeBg = isInProgress ? MpColors.lightBlueBg : (isCompleted ? MpColors.greenBg : task.priorityBg);

    return MpCard(
      topBorderColor: isCompleted ? MpColors.green : task.topBorder,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MpBadge(text: badgeLabel, fg: badgeFg, bg: badgeBg),
              Text(task.time, style: const TextStyle(fontSize: 11.5, color: MpColors.textFaint)),
            ],
          ),
          const SizedBox(height: 10),
          Text(task.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15.5, color: MpColors.textDark, height: 1.3)),
          const SizedBox(height: 6),
          Text(task.desc, style: const TextStyle(fontSize: 12.5, color: MpColors.textMuted, height: 1.4)),
          const SizedBox(height: 8),
          Row(children: [
            const Icon(Icons.people_alt_outlined, size: 13, color: MpColors.textFaint),
            const SizedBox(width: 6),
            Text(task.team, style: const TextStyle(fontSize: 12, color: MpColors.textMuted, fontWeight: FontWeight.w500)),
          ]),
          const SizedBox(height: 12),
          if (isCompleted)
            Row(children: const [
              Icon(Icons.check_circle, color: MpColors.green, size: 16),
              SizedBox(width: 6),
              Text('Görev tamamlandı', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: MpColors.greenDark)),
            ])
          else
            Row(children: [
              Expanded(
                child: isInProgress
                    ? MpPrimaryButton(label: 'Güncelle', color: MpColors.orange, onTap: onUpdate)
                    : MpSecondaryButton(label: 'Detaylar', onTap: onDetails),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: isInProgress
                    ? MpPrimaryButton(label: 'Tamamla', color: MpColors.green, onTap: onComplete)
                    : MpPrimaryButton(label: 'Başlat', onTap: onStart),
              ),
            ]),
        ],
      ),
    );
  }
}
