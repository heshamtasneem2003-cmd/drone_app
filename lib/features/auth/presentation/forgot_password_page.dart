import 'package:flutter/material.dart';
import 'package:graduation_project/widgets/auth_text_field.dart';
import 'package:graduation_project/widgets/action_button.dart';
import 'package:graduation_project/widgets/emergency_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
  preferredSize: const Size.fromHeight(100.0), // الارتفاع اللي بيسمح بالانحناء
  child: AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
      onPressed: () {
        Navigator.pop(context); // يرجعك لصفحة اللوجين
      },
    ),
    title: const Text(
      'نسيت كلمة المرور', 
      style: TextStyle(
        color: Color.fromARGB(255, 0, 0, 0), 
        fontWeight: FontWeight.w900, 
        fontSize: 30
      )
    ),
    centerTitle: true,
    backgroundColor: const Color.fromARGB(255, 174, 12, 12), // اللون الأحمر الموحد
    elevation: 10,
    shadowColor: const Color.fromARGB(255, 174, 12, 12).withOpacity(0.5),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(50), // الانحناء اللي تحت
      ),
    ),
    toolbarHeight: 100.0,
  ),
),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Text(
                'اعادة تعيين كلمة المرور الخاصه',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff76545D),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'أدخل عنوان بريدك الألكتروني المسجل أدناه لتلقي تعليمات أعادة تعيين كلمة المرور',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 30),
              const AuthTextField(label: 'E-mail', icon: Icons.mail),
              const SizedBox(height: 60),
              // زرار Reset Password بالتصميم الاحترافي
Center(
  child: InkWell(
    onTap: () {
      // هنا كود الـ Reset اللي كنتِ كاتباه
      debugPrint('Reset Password Pressed');
    },
    borderRadius: BorderRadius.circular(18),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 55,
      width: 200, // المقاس الموحد بتاعنا
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // تدرج ألوان أحمر
        gradient: const LinearGradient(
          colors: [
            Color(0xFFD11212), 
            Color(0xFF910C0C)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        // ظل الزرار عشان يبان بارز
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD11212).withOpacity(0.6),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Text(
        'اعادة تعيين كلمة المرور',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: InkWell(
                  onTap: () async {
  // الرقم اللي إنتي عايزاه يظهر (مثلاً 123 للإسعاف في مصر)
  const String phoneNumber = '123'; 
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  
  // التأكد إن الجهاز يقدر يفتح لوحة الاتصال
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    // لو فيه مشكلة في التشغيل (زي المحاكي مثلاً) يطلع رسالة
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تعذر فتح لوحة الاتصال')),
    );
  }
},
                  borderRadius: BorderRadius.circular(50),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 70, // زودت الطول سنة عشان يبقى أوضح
                    width: 280, // عرض مناسب للكلمة والأيقونة
                    decoration: BoxDecoration(
                      // 1. تدرج ألوان أحمر "ناري" للطوارئ
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFE53935), // أحمر فاتح ومنور
                          Color(0xFFB71C1C), // أحمر غامق قوي
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(50),
                      // 2. ظل أحمر منتشر بيدي إيحاء بالخطر أو الأهمية
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFB71C1C).withOpacity(0.6),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                      // 3. إطار بسيط بلون فاتح بيدي شكل شيك
                      border: Border.all(
                        color: Colors.white24,
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // أيقونة سماعة التليفون مع تأثير بسيط
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.phone_in_talk,
                              size: 28,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 15),
                          const Text(
                            'الأتصال بالطوارئ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
