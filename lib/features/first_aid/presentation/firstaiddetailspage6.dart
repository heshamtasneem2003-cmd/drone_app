import 'package:flutter/material.dart';

class Firstaiddetailspage6 extends StatelessWidget {
  const Firstaiddetailspage6({super.key});

  @override
  Widget build(BuildContext context) {
    const Color orangeTheme = Colors.green; // لون العنوان والأيقونة للتسمم
    const Color lightBg = Color(0xFFEAFBEA); // لون الهيدر الخلفي

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
                                    "التسمم",
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
                              child: const Icon(Icons.science, color: orangeTheme, size: 40),
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
                          _buildSectionHeader("كيفية التعامل مع حالات التسمم المختلفة", Icons.check_circle_outline, Colors.green),
                          const SizedBox(height: 20),
                          _buildStepItem("1", "حاول تحديد نوع المادة السامة والكمية التي تم تناولها"),
                          _buildStepItem("2", "اتصل بمركز السموم أو الإسعاف فوراً وأبلغهم بالتفاصيل"),
                          _buildStepItem("3", "إذا كان السم على الجلد، اغسله بماء جاري لمدة 15-20 دقيقة"),
                          _buildStepItem("4", "إذا كان السم مستنشقاً، انقل المصاب للهواء الطلق فوراً"),
                          _buildStepItem("5", "إذا فقد المصاب وعيه، تأكد من تنفسه وضعه في وضع الإفاقة"),
                          _buildStepItem("6", "خذ وعاء المادة السامة معك إلى المستشفى للتعرف عليها"),
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
                        _buildWarningItem("لا تجبر المصاب على التقيؤ إلا إذا طلب منك الطبيب ذلك"),
                        _buildWarningItem("لا تعطِ المصاب أي شيء عن طريق الفم إذا كان فاقداً للوعي"),
                        _buildWarningItem("احذر من ملامسة المادة السامة بيديك المجردتين"),
                        _buildWarningItem("في حال التسمم بالمواد الكاوية (مثل المنظفات)، لا تحاول معادلتها بشرب الخل أو الليمون"),
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