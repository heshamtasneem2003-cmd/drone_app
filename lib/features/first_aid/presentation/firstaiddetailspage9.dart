import 'package:flutter/material.dart';

class Firstaiddetailspage9 extends StatelessWidget {
  const Firstaiddetailspage9({super.key});

  @override
  Widget build(BuildContext context) {
    const Color orangeTheme = Color.fromRGBO(255, 171, 64, 1); // لون الشمس (Orange)
    const Color lightBg = Color(0xFFFFF3E0); // لون الهيدر الخلفي

    return Directionality(
      textDirection: TextDirection.rtl, // تظبيط الاتجاه للعربي
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // --- الهيدر ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
                    decoration: const BoxDecoration(
                      color: lightBg,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        // الصف العلوي: زر الرجوع
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _buildHeaderButton("رجوع", Icons.arrow_back, () {
                              Navigator.pop(context); // العودة للهوم
                            }),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // صف العنوان والأيقونة
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "ضربة الشمس",
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: orangeTheme,
                                    ),
                                  ),
                                  Text(
                                    "",
                                    style: TextStyle(fontSize: 13, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.thermostat, color: orangeTheme, size: 40),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // --- كارت الخطوات الأبيض ---
                  Transform.translate(
                    offset: const Offset(0, -30),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildSectionHeader("كيفية التعامل مع الإجهاد الحراري وضربات الشمس", Icons.check_circle_outline, Colors.green),
                          const SizedBox(height: 20),
                          _buildStepItem("1", "انقل المصاب فوراً إلى مكان بارد أو مظلل"),
                          _buildStepItem("2", "انزع الملابس الزائدة عن المصاب لتسهيل تبريد الجسم"),
                          _buildStepItem("3", "استخدم كمادات ماء بارد (وليس ثلج) على الرقبة والإبطين والفخذ"),
                          _buildStepItem("4", "رش المصاب برذاذ الماء البارد مع استخدام مروحة لتهويته"),
                          _buildStepItem("5", "إذا كان المصاب واعياً، أعطه رشفات صغيرة من الماء البارد"),
                          _buildStepItem("6", "إذا فقد المصاب وعيه، ضعه في وضع الإفاقة واتصل بالإسعاف فوراً"),
                          _buildStepItem("7", "استمر في محاولات التبريد حتى تنخفض درجة حرارته"),
                        ],
                      ),
                    ),
                  ),

                  // --- قسم تحذيرات مهمة ---
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEBEE),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        _buildSectionHeader("تحذيرات مهمة", Icons.warning_amber_rounded, Colors.red),
                        const SizedBox(height: 15),
                        _buildWarningItem("لا تعطِ المصاب أي مشروبات تحتوي على الكافيين أو السكريات العالية"),
                        _buildWarningItem("ممنوع استخدام الثلج المباشر على الجلد؛ قد يؤدي لانقباض الأوعية وتأخر التبريد"),
                        _buildWarningItem("لا تترك المصاب وحده حتى تنخفض حرارته وتنتظم علاماته الحيوية"),
                        _buildWarningItem("راقب علامات الخطورة (ارتباك، فقدان وعي، توقف التعرق مع حرارة عالية)"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100), // مساحة للزر العائم
                ],
              ),
            ),

            // الزر الأحمر العائم
            Positioned(
              bottom: 25,
              left: 25,
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: const Color(0xFFE57373),
                shape: const CircleBorder(),
                child: const Icon(Icons.phone_in_talk, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderButton(String text, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(width: 5),
            Icon(icon, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 10),
        Expanded(child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color == Colors.red ? color : Colors.black87))),
      ],
    );
  }

  Widget _buildStepItem(String number, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(color: const Color(0xFFFEF5E7), borderRadius: BorderRadius.circular(10)),
            child: Center(child: Text(number, style: const TextStyle(color: Color(0xFFE67E22), fontWeight: FontWeight.bold))),
          ),
          const SizedBox(width: 15),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14, color: Colors.black87))),
        ],
      ),
    );
  }

  Widget _buildWarningItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: CircleAvatar(radius: 3, backgroundColor: Colors.red),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(color: Colors.redAccent, fontSize: 13))),
        ],
      ),
    );
  }
}