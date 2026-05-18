import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graduation_project/features/auth/presentation/signup_page.dart';
import 'package:graduation_project/features/auth/presentation/forgot_password_page.dart';
import 'package:graduation_project/features/splash/presentation/splash_page.dart';
import 'package:graduation_project/widgets/auth_text_field.dart';
import 'package:graduation_project/widgets/action_button.dart';
import 'package:graduation_project/widgets/emergency_button.dart';
import 'package:graduation_project/features/auth/presentation/form_page.dart';
import 'package:url_launcher/url_launcher.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signInWithGoogle() async {
    try {
      setState(() => _isLoading = true);
      final googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();

      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final GoogleSignInClientAuthorization? googleClientAuth = await googleUser
          .authorizationClient
          .authorizationForScopes(<String>['email', 'profile', 'openid']);

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleClientAuth?.accessToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FormPage()),
        );
      }
    } catch (e) {
      debugPrint("Error Google Sign-In: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("حدث خطأ في تسجيل الدخول")),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _loginWithEmailPassword() async {
    try {
      setState(() => _isLoading = true);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FormPage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? "E-mail Or Password is incorrect"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
  preferredSize: const Size.fromHeight(100.0), // عشان ندي مساحة للارتفاع
  child: AppBar(
    // 1. سهم الرجوع
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
      onPressed: () {
        // ده هيرجعك لصفحة الـ Splash زي ما طلبتي
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => const SplashPage())
        );
      },
    ),
    title: const Text(
      " تسجيل الدخول", 
      style: TextStyle(
        color: Color.fromARGB(255, 0, 0, 0), 
        fontWeight: FontWeight.w900, 
        fontSize: 30
      )
    ),
    centerTitle: true,
    backgroundColor: const Color.fromARGB(255, 174, 12, 12), // اللون الأحمر بتاعك
    elevation: 10,
    shadowColor: const Color.fromARGB(255, 174, 12, 12).withOpacity(0.5),
    // 2. الجزء المنحني اللي تحت
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(50), // درجة الانحناء
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
              const SizedBox(height: 70),
              AuthTextField(
                controller: _emailController,
                label: " الأيميل",
                icon: Icons.mail,
                obscureText: false,
              ),
              const SizedBox(height: 30),
              AuthTextField(
                controller: _passwordController,
                label: "كلمة المرور",
                icon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 40),
              _isLoading
                  ? const CircularProgressIndicator(color: Color(0xff76545D))
                  : // 1. هنستخدم Center عشان الزرار يبقى في النص بالظبط
               Center(
                   child: InkWell(
                    // 2. بنادي على الدالة بتاعتك زي ما هي من غير تغيير
                onTap: _isLoading ? null : _loginWithEmailPassword, 
                borderRadius: BorderRadius.circular(18),
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                     height: 55,
                      width: 200, // المقاس اللي طلبتيه (200)
                       alignment: Alignment.center,
                        decoration: BoxDecoration(
                             // 3. التدرج اللوني الأحمر اللي بيدي فخامة
                  gradient: const LinearGradient(
                     colors: [
                         Color(0xFFD11212), 
                            Color(0xFF910C0C)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(40),
        // 4. الظل (Shadow) اللي بيخلي الزرار بارز
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD11212).withOpacity(0.6),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: _isLoading 
          ? const CircularProgressIndicator(color: Colors.white) 
          : const Text(
              " تسجيل الدخول",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
    ),
  ),
),
              const SizedBox(height: 25),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordPage(),
                      ),
                    );
                  },
                  child: const Text(
                    " هل نسيت كلمة المرور؟",
                    style: TextStyle(
                      color: Color(0xFF910C0C),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    " ليس لدي حساب",
                    style: TextStyle(fontSize: 20 , color: Color(0xFFD11212)),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'تسجيل ',
                      style: TextStyle(
                        color: Color(0xFF910C0C),
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // الزرار المطلوب
              InkWell(
                onTap: _signInWithGoogle,
                child: const Text(
                  'تسجيل الدخول بجوجل',
                  style: TextStyle(
                    color: Color(0xFF910C0C),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),

              const SizedBox(height: 80),


              // زرار الطوارئ (Emergency Call) بالتأثيرات وكود الاتصال
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
            ],
          ),
        ),
      ),
    );
  }
}


