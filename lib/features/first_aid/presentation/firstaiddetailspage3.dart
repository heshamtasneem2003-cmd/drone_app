import 'package:flutter/material.dart';

class Firstaiddetailspage3 extends StatelessWidget {
  const Firstaiddetailspage3({super.key});

  @override
  Widget build(BuildContext context) {
    const Color orangeTheme = Colors.red; // لون العنوان والأيقونة للجروح
    const Color lightBg = Color(0xFFFCD3D1); // لون الهيدر الخلفي

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
                              Navigator.pop(context);
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
                                    "الجروح والنزيف",
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
                              child: const Icon(Icons.healing, color: orangeTheme, size: 40),
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
                          _buildSectionHeader("خطوات إيقاف النزيف وتنظيف الجروح", Icons.check_circle_outline, Colors.green),
                          const SizedBox(height: 20),
                          _buildStepItem("1", "اغسل يديك جيداً بالماء والصابون أو ارتدِ قفازات طبية معقمة"),
                          _buildStepItem("2", "إذا كان هناك نزيف اضغط مباشرة على الجرح بقطعة قماش نظيفة"),
                          _buildStepItem("3", "حافظ على الضغط المستمر لمدة 5-10 دقائق دون رفع القماش"),
                          _buildStepItem("4", "إذا نزف القماش، ضع قطعة أخرى فوقها ولا تزل الأولى"),
                          _buildStepItem("5", "ارفع العضو المصاب فوق مستوى القلب لتقليل تدفق الدم"),
                          _buildStepItem("6", "بعد توقف النزيف، نظف الجرح بلطف بالماء النظيف الجاري"),
                          _buildStepItem("7", "أزل أي أوساخ بملقط معقم (عقمه بالكحول أولاً)"),
                          _buildStepItem("8", "جفف المنطقة بلطف بقطعة شاش نظيفة"),
                          _buildStepItem("9", "غطِ الجرح بضمادة معقمة أو لاصق طبي مناسب"),
                          _buildStepItem("10", "غير الضمادة يومياً أو عندما تتسخ أو تبتل"),
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
                        _buildWarningItem("لا تزل الأجسام الكبيرة العالقة في الجرح - اتركها واطلب المساعدة"),
                        _buildWarningItem("الجروح العميقة قد تحتاج خياطة - راجع الطبيب خلال 6-8 ساعات"),
                        _buildWarningItem("راقب علامات العدوى (احمرار متزايد، تورم، صديد)"),
                        _buildWarningItem("إذا كان الجرح ملوثاً، تحقق من تطعيم التيتانوس"),
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
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color == Colors.red ? color : Colors.black87)),
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