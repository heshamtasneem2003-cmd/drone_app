import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launchCaller(String number) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: number,
  );
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    throw 'Could not launch $launchUri';
  }
}

class EmergencyCard extends StatefulWidget {
  final String title;
  final String label;
  final Color color;

  const EmergencyCard(
      {super.key,
      required this.title,
      required this.label,
      required this.color});

  @override
  State<EmergencyCard> createState() => _EmergencyCardState();
}

class _EmergencyCardState extends State<EmergencyCard> {
  bool pressed = false;

  Future<void> _call() async {
    final uri = Uri.parse('tel:${widget.title}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: _call,
        onHighlightChanged: (v) => setState(() => pressed = v),
        child: AnimatedScale(
          scale: pressed ? 0.93 : 1,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOutBack,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(pressed ? 0.15 : 0.25),
                  blurRadius: pressed ? 6 : 12,
                  offset: Offset(0, pressed ? 2 : 6),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(widget.title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: widget.color)),
                const SizedBox(height: 4),
                Text(widget.label, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmergencyNumbersWidget extends StatelessWidget {
  const EmergencyNumbersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          Expanded(
            child: EmergencyCard(
              title: '123',
              label: 'الإسعاف',
              color: Colors.red,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: EmergencyCard(
              title: '180',
              label: 'المطافي',
              color: Colors.orange,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: EmergencyCard(
              title: '122',
              label: 'النجدة',
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

class EmergencySectionCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color normalColor;
  final Color activeColor;
  final Color iconColor;
  final VoidCallback? onTap;
  final TextStyle? subtitleStyle;

  const EmergencySectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.normalColor,
    required this.activeColor,
    required this.iconColor,
    this.onTap,
    this.subtitleStyle,
  });

  @override
  State<EmergencySectionCard> createState() => _EmergencySectionCardState();
}

class _EmergencySectionCardState extends State<EmergencySectionCard> {
  bool isSelected = false;

  void toggleCard() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleCard,
      child: AnimatedScale(
        scale: isSelected ? 1.05 : 1.0, // تكبير بسيط جدًا
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isSelected ? widget.activeColor : widget.normalColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// الايقونة
              AnimatedRotation(
                turns: isSelected ? 10 / 360 : 0,
                duration: const Duration(milliseconds: 300),
                child: AnimatedScale(
                  scale: isSelected ? 1.15 : 1,
                  duration: const Duration(milliseconds: 300),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? widget.iconColor.withOpacity(0.25)
                          : widget.iconColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      widget.icon,
                      size: 60,
                      color: isSelected ? Colors.white : widget.iconColor,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.black87 : Colors.black87,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                widget.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color:
                      isSelected ? Colors.grey.shade600 : Colors.grey.shade600,
                ),
              ),

              if (isSelected) ...[
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "اقرأ المزيد",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: widget.iconColor,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: widget.iconColor,
                      ),
                    ],
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

void showEmergencyMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true, // عشان لو المحتوى كبر يتحكم في الارتفاع
    builder: (context) {
      return Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25), // حواف دائرية زي التصميم
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "خيارات الطوارئ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 25),

            // زرار الاتصال بالإسعاف (الأحمر)
            _buildEmergencyButton(
              label: "الإتصال بالإسعاف ",
              icon: Icons.phone_in_talk,
              color: const Color(0xFFD90429),
              onTap: () {
                _launchCaller('123');
                Navigator.pop(context);
              },
            ),

            const SizedBox(height: 12),

            // زرار اتصال مباشر (شفاف بحدود حمراء)
            OutlinedButton(
              onPressed: () {
                _launchCaller('112');
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                side: const BorderSide(color: Color(0xFFEF233C), width: 1.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text(
                "الطوارئ 112",
                style: TextStyle(
                    color: Color(0xFFEF233C), fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 15),

            // نص التنبيه
            const Text(
              "استخدم هذا الزر في حالات الطوارئ فقط!",
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 10),

            // زر الإغلاق (X) أو إلغاء
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("إلغاء",
                  style: TextStyle(color: Colors.grey, fontSize: 16)),
            ),
          ],
        ),
      );
    },
  );
}

// ويدجت مساعد للزراير عشان الكود يبقى أنظف
Widget _buildEmergencyButton(
    {required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap}) {
  return ElevatedButton.icon(
    onPressed: onTap,
    icon: Icon(icon, color: Colors.white),
    label: Text(label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 55),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
  );
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.grey.withOpacity(0.2) // لون الخطوط
      ..strokeWidth = 1.0;

    // رسم الخطوط الأفقية
    for (double i = 0; i <= size.height; i += 30) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
    // رسم الخطوط الرأسية
    for (double i = 0; i <= size.width; i += 30) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}