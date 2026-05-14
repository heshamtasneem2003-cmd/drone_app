import 'package:flutter/material.dart';
import 'package:graduation_project/widgets/auth_text_field.dart';
import 'package:graduation_project/widgets/action_button.dart';
import 'package:graduation_project/widgets/emergency_button.dart';
import 'package:graduation_project/features/auth/presentation/form_page.dart';
import 'package:url_launcher/url_launcher.dart';
class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
  preferredSize: const Size.fromHeight(100.0), // نفس الارتفاع بتاع صفحة اللوجين
  child: AppBar(
    // سهم الرجوع
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
      onPressed: () {
        // هنا التعديل: هيرجعك لصفحة اللوجين
        Navigator.pop(context); 
      },
    ),
    title: const Text(
      'Sign up', 
      style: TextStyle(
        color: Color.fromARGB(255, 0, 0, 0), 
        fontWeight: FontWeight.w900, 
        fontSize: 30
      )
    ),
    centerTitle: true,
    backgroundColor: const Color.fromARGB(255, 174, 12, 12), // نفس الدرجة
    elevation: 10,
    shadowColor: const Color.fromARGB(255, 174, 12, 12).withOpacity(0.5),
    // الشكل المنحني
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(50),
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
              const SizedBox(height: 20),
              const AuthTextField(label: 'First Name', icon: Icons.person),
              const SizedBox(height: 25),
              const AuthTextField(label: 'Last Name', icon: Icons.person),
              const SizedBox(height: 25),
              const AuthTextField(
                label: 'Password',
                icon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 25),
              const AuthTextField(
                label: 'Confirm Password',
                icon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 25),
              const AuthTextField(label: 'Email', icon: Icons.email),
              const SizedBox(height: 40),

              // استبدلي الـ ActionButton بالجزء ده بالظبط
Center(
  child: InkWell(
    onTap: () {
      // الكود اللي كان عندك في الـ onPressed بالحرف
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FormPage()),
      );
    },
    borderRadius: BorderRadius.circular(18),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 55,
      width: 200, // نفس المقاس اللي وحدناه
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // التدرج والظل اللي بيخلي الشكل احترافي
        gradient: const LinearGradient(
          colors: [Color(0xFFD11212), Color(0xFF910C0C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD11212).withOpacity(0.8),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Text(
        'Sign up',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
),
              const SizedBox(height: 60),
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
                            'Emergency Call',
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
            ],
          ),
        ),
      ),
    );
  }
}
