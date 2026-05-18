import 'package:flutter/material.dart';

class Firstaiddetailspage1 extends StatelessWidget {
  const Firstaiddetailspage1({super.key});

  @override
  Widget build(BuildContext context) {
    const Color orangeTheme = Color(0xFFE67E22); // لون العنوان والأيقونة
    const Color lightBg = Color(0xFFFEF5E7); // لون الهيدر الخلفي

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // --- الهيدر (نسخة طبق الأصل) ---
                  Container(
                    width: double.infinity,
                      height: 220,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _buildHeaderButton("رجوع", Icons.arrow_forward ,(){
                              Navigator.pop(context);
                            }),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // صف العنوان والأيقونة المربعة
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text(
                                  "الحروق",
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: orangeTheme,
                                  ),
                                ),
                                Text(
                                  "كيفية التعامل مع الحروق بمختلف درجاتها",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black54),
                                      textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                            ),
                            const SizedBox(width: 20),
                            // الأيقونة المربعة المنحنية (نفس الصورة)
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10)
                                ],
                              ),
                              child: const Icon(Icons.local_fire_department,
                                  color: orangeTheme, size: 40),
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
                              offset: const Offset(0, 10))
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildSectionHeader("خطوات الإسعافات الأولية",
                              Icons.check_circle_outline, Colors.green),
                          const SizedBox(height: 20),
                          _buildStepItem("1",
                              "أبعد المصاب عن مصدر الحرق فوراً (نار، ماء ساخن، كهرباء)"),
                          _buildStepItem("2",
                              "قم بإزالة الملابس المحترقة إلا إذا كانت ملتصقة بالجلد"),
                          _buildStepItem("3",
                              "ضع المنطقة المحروقة تحت الماء البارد الجاري (15-25 درجة) لمدة 10-20 دقيقة"),
                          _buildStepItem("4",
                              "انزع المجوهرات والملابس الفضفاضة والساعات قبل حدوث التورم"),
                          _buildStepItem("5",
                              "لا تستخدم الثلج مباشرة على الحرق لأنه قد يزيد الضرر"),
                          _buildStepItem("6",
                              "غط الحرق بضمادة معقمة غير لاصقة أو قماش نظيف"),
                          _buildStepItem("7",
                              "لا تضع ثلج أو معجون أسنان أو زيت أو زبدة أو بياض بيض على الحرق"),
                          _buildStepItem("8",
                              "ارفع المنطقة المحروقة فوق مستوى القلب إن أمكن لتقليل التورم"),
                          _buildStepItem("9",
                              "إذا كان الحرق كبيراً (أكبر من راحة اليد) أو عميقاً، اطلب المساعدة الطبية فوراً"),
                          _buildStepItem("10",
                              "راقب علامات العدوى: احمرار متزايد، تورم، رائحة كريهة، صديد"),
                          _buildStepItem("11",
                              "حروق الدرجة الثالثة (بيضاء أو سوداء): لا تنزع الملابس واطلب الإسعاف فورًا"),
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
                        _buildSectionHeader("تحذيرات مهمة",
                            Icons.warning_amber_rounded, Colors.red),
                        const SizedBox(height: 15),
                        _buildWarningItem(
                            "لا تفقع الفقاعات الناتجة عن الحرق - فهي طبقة حماية طبيعية"),
                        _buildWarningItem(
                            "احذر من علامات الصدمة (شحوب، برودة، تعرق، نبض سريع ضعيف)"),
                        _buildWarningItem(
                            "الحروق الكيميائية تحتاج معالجة خاصة - اغسل بماء جاري لمدة 20 دقيقة"),
                        _buildWarningItem(
                            "حروق الوجه والعينين والأذنين واليدين والأعضاء التناسلية تحتاج عناية طبية"),
                        _buildWarningItem(
                            "الأطفال وكبار السن أكثر عرضة لمضاعفات الحروق"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100), // مساحة للزر العائم
                ],
              ),
            ),

            // الزر الأحمر العائم (الاتصال)
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

  // ويدجت زر الهيدر المربع (مثل رجوع ومشاركة)
  Widget _buildHeaderButton(String text, IconData icon , VoidCallback onTap) {
    return InkWell(
      onTap: onTap, 
      child:Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(width: 5),
          Icon(icon, size: 16),
        ],
      ),
      ),
    );
  }

  // رأس القسم (خطوات أو تحذيرات)
  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color == Colors.red ? color : Colors.black87)),
        const SizedBox(width: 10),
        Icon(icon, color: color),
      ],
    );
  }

  // عنصر الخطوة المرقمة
  Widget _buildStepItem(String number, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Text(text,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 14, color: Colors.black87)),
          ),
          const SizedBox(width: 15),
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: const Color(0xFFFEF5E7),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(number,
                    style: const TextStyle(
                        color: Color(0xFFE67E22),
                        fontWeight: FontWeight.bold))),
          ),
        ],
      ),
    );
  }

  // عنصر التحذير (التعديل النهائي المظبوط)
  Widget _buildWarningItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
          Expanded( 
            child: Text(
              text,
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.redAccent, fontSize: 13),
            ),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: const CircleAvatar(radius: 3, backgroundColor: Colors.red),
          ),
        ], // قفلة الـ children
      ),
    );
  }
}