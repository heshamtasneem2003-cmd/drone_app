import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project/features/auth/presentation/login_page.dart';
import 'package:graduation_project/features/home/presentation/home_page.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // --- الـ AppBar بتاعك زي ما هو بالظبط من غير تغيير ---
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110.0),
        child: AppBar(
          title: const Text(
            " نظام الطوارئ السريع ",
            style: TextStyle(
              color: Color.fromARGB(255, 218, 193, 193),
              fontWeight: FontWeight.w900,
              fontSize: 23,
              letterSpacing: 1.2,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 174, 12, 12),
          elevation: 8,
          shadowColor: const Color.fromARGB(255, 174, 12, 12).withOpacity(0.7),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            ),
          ),
          toolbarHeight: 100.0,
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline, color: Colors.white70),
              onPressed: () {
                      showDialog(
                         context: context,
                        builder: (BuildContext context) {
                        return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          "عن المشروع",
          textAlign: TextAlign.right,
          style: TextStyle(color: Color.fromARGB(255, 174, 12, 12), fontWeight: FontWeight.bold),
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "نظام الإغاثة الذكي هو مشروع يهدف لتقليل وقت استجابة الطوارئ باستخدام طائرات الدرون لتوصيل المساعدات الأولية.",
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 15),
            Text(
              "إعداد: فريق عمل مشروع تخرج 2026",
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("حسناً", style: TextStyle(color: Color.fromARGB(255, 174, 12, 12))),
          ),
        ],
      );
    },
  );
},
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const CircleAvatar(
                radius: 112,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 110,
                  backgroundImage: AssetImage('images/Doroun.png'),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                ' ',
                style: TextStyle(
                  color: Color.fromARGB(255, 118, 52, 93),
                  fontSize: 32,
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 20),
              
              // --- زرار الـ Start الجديد بالتأثيرات الاحترافية ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: InkWell(
                  onTap: () {
                    if (FirebaseAuth.instance.currentUser != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(100),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 65,
                    width: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      // تدرج ألوان احترافي
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 194, 105, 105),
                          Color(0xffE29595),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(100),
                      // تأثير الظل (Shadow)
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 209, 18, 18).withOpacity(0.4),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Text(
                      " أبدأ",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 70), // تقليل الـ SizedBox عشان التصميم يبقى ملموم

             // --- زرار Emergency Call المطور ---
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
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}