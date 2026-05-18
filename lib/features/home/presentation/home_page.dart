import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

// استيراد الصفحات - تأكدي من المسارات في مشروعك
import 'package:graduation_project/features/first_aid/presentation/firstaiddetailspage1.dart';
import 'package:graduation_project/features/first_aid/presentation/firstaiddetailspage2.dart';
import 'package:graduation_project/features/first_aid/presentation/firstaiddetailspage3.dart';
import 'package:graduation_project/features/first_aid/presentation/firstaiddetailspage4.dart';
import 'package:graduation_project/features/first_aid/presentation/firstaiddetailspage5.dart';
import 'package:graduation_project/features/first_aid/presentation/firstaiddetailspage6.dart';
import 'package:graduation_project/features/first_aid/presentation/firstaiddetailspage7.dart';
import 'package:graduation_project/features/first_aid/presentation/firstaiddetailspage8.dart';
import 'package:graduation_project/features/first_aid/presentation/firstaiddetailspage9.dart';
import 'package:graduation_project/features/first_aid/presentation/firstaiddetailspage10.dart';
import 'package:graduation_project/features/first_aid/presentation/firstaiddetailspage11.dart';
import 'package:graduation_project/features/first_aid/presentation/firstaiddetailspage12.dart';
import 'package:graduation_project/features/splash/presentation/splash_page.dart';
import 'package:graduation_project/features/drone/presentation/drone_request_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage> {
  int? _hoveredIndex; // لتتبع الكارت الملموس في الشبكة
  int? _hoveredEmergencyIndex; // لتتبع كروت الطوارئ العلوية
  String _currentAddress = "... اضغط لطلب الموقع";

  // دالة تحديد الموقع اللي إنتي عاملاها
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    Placemark place = placemarks[0];

    setState(() {
      _currentAddress = "${place.street}, ${place.locality}";
    });
  }
  // دالة الاتصال الهاتفي
  Future<void> _makeCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // --- الهيدر الاحترافي ---
                  Stack(
                    children: [
                      Container(
                        height: 240,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFD90429), Color.fromARGB(255, 174, 12, 12),],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(35),
                            bottomRight: Radius.circular(35),
                          ),
                          boxShadow: [
                                   BoxShadow(
                                      color: const Color(0xFFD90429).withOpacity(0.4), // ظل بلون التصميم عشان يبقى شيك
                                         blurRadius: 20, // انتشار الظل
                                       offset: const Offset(0, 10), // مكان الظل لتحت
                        ),
                          ],
                        ),
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // سهم الرجوع لصفحة Start (SplashPage)
                                    IconButton(
                                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(builder: (context) => const SplashPage()),
                                        );
                                      },
                                    ),
                                    const Text(
                                      "الإسعافات الأوليه🤍",
                                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                                    ),
                                    // زر تسجيل الخروج (Sign Out)
                                    IconButton(
                                      icon: const Icon(Icons.logout, color: Colors.white),
                                      onPressed: () async {
                                        await FirebaseAuth.instance.signOut();
                                        if (mounted) {
                                          Navigator.of(context).pushAndRemoveUntil(
                                            MaterialPageRoute(builder: (context) => const SplashPage()),
                                            (route) => false,
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "دليلك الشامل للتعامل مع حالات الطوارئ",
                                  style: TextStyle(color: Color.fromARGB(179, 0, 0, 0), fontSize: 14 , fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 30),
                                // السيرش بار الشفاف
                                Container(
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(color: Colors.white.withOpacity(0.25) , width: 1),
                                  ),
                                  child: const TextField(
                                    textAlignVertical: TextAlignVertical.center,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText: "ابحث عن نوع الإصابة...",
                                      hintStyle: TextStyle(color: Color.fromARGB(179, 0, 0, 0)),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                                      suffixIcon: Icon(Icons.search, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // --- كروت أرقام الطوارئ (بالأنيميشن) ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSmallEmergencyCard(0, "180", "المطافي", Colors.orange), // ضفنا رقم 0
                        _buildSmallEmergencyCard(1, "122", "النجدة", Colors.blue),   // ضفنا رقم 1
                        _buildSmallEmergencyCard(2, "123", "الإسعاف", Colors.red),    // ضفنا رقم 2
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "دليل الإسعافات الأولية",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  // --- شبكة الإسعافات الـ 12 (أنيميشن وتنسيق ألوان) ---
                  SizedBox(width: 10),
                   GridView.count(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),

                      crossAxisCount: 2,
                      shrinkWrap: true, // 👈 مهم
                      physics: NeverScrollableScrollPhysics(), // عمودين
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.8, // علشان الطول يبقى مظبوط
                      children: [
                        EmergencySectionCard(
                          icon: Icons.personal_injury,
                          title: "الكسور",
                          subtitle: "كيفية التعامل مع الكسور والإلتواءات",
                          
                          normalColor: Colors.white,
                          activeColor: Color(0xFFD4EAFD),
                          iconColor: Colors.blue,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Firstaiddetailspage2()),
                            );
                          },
                        ),
                        EmergencySectionCard(
                          icon: Icons.healing,
                          title: "الجروح",
                          subtitle: "كيفيةإيقاف النزيف وتنظيف الجرح",
                          normalColor: Colors.white,
                          activeColor: Color(0xFFFCD3D1),
                          iconColor: Colors.red,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Firstaiddetailspage3()),
                            );
                          },
                        ),
                        EmergencySectionCard(
                          icon: Icons.local_fire_department_outlined,
                          title: "الحروق",
                          subtitle: "كيفية التعامل مع الحروق",
                          normalColor: Colors.white,
                          activeColor: Color(0xFFFFD8A7),
                          iconColor: Colors.deepOrange,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Firstaiddetailspage1()),
                            );
                          },
                        ),
                        EmergencySectionCard(
                          icon: Icons.air,
                          title: "الإختناق",
                          subtitle: "التعامل مع حالات الإختناق",
                          normalColor: Colors.white,
                          activeColor: Color(0xFFDFF0F9),
                          iconColor: Colors.blueGrey,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Firstaiddetailspage4()),
                            );
                          },
                        ),
                        EmergencySectionCard(
                          icon: Icons.flash_on,
                          title: "الصدمة",
                          subtitle: "التعرف على الصدمة والتعامل معها",
                          normalColor: Colors.white,
                          activeColor: Color(0xFFEEE5FC),
                          iconColor: Colors.deepPurple,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Firstaiddetailspage5()),
                            );
                          },
                        ),
                        EmergencySectionCard(
                          icon: Icons.science,
                          title: "التسمم",
                          subtitle: "الإسعافات الأولية لحالات التسمم",
                          normalColor: Colors.white,
                          activeColor: Color(0xFFEAFBEA),
                          iconColor: Colors.green,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Firstaiddetailspage6()),
                            );
                          },
                        ),
                        EmergencySectionCard(
                          icon: Icons.water_drop_outlined,
                          title: "غيبوبة السكر",
                          subtitle: "التعامل مع إنخفاض وارتفاع السكر في الدم",
                          normalColor: Colors.white,
                          activeColor: Color(0xFFE5F7FF),
                          iconColor: Colors.lightBlueAccent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Firstaiddetailspage7()),
                            );
                          },
                        ),
                        EmergencySectionCard(
                          icon: Icons.visibility,
                          title: "إصابات العين",
                          subtitle: "التعامل مع إصابات العين المختلفة",
                          normalColor: Colors.white,
                          activeColor: Color(0xFFE6FCFF),
                          iconColor: Colors.cyan,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Firstaiddetailspage8()),
                            );
                          },
                        ),
                        EmergencySectionCard(
                          icon: Icons.thermostat,
                          title: "ضربة الشمس",
                          subtitle: "علاج ضربة الشمس والإجهاد الحراري",
                          normalColor: Colors.white,
                          activeColor: Color(0xFFF9F0E2),
                          iconColor: Colors.orangeAccent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Firstaiddetailspage9()),
                            );
                          },
                        ),
                        EmergencySectionCard(
                          icon: Icons.medical_services,
                          title: "شنطة الإسعافات الأولية",
                          subtitle:
                              "المحتويات الأساسية لشنطة الإسعافات الأولية",
                          normalColor: Colors.white,
                          activeColor: Color(0xFFCDD4F8),
                          iconColor: Colors.indigo,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Firstaiddetailspage10()),
                            );
                          },
                        ),
                        EmergencySectionCard(
                          icon: Icons.favorite,
                          title: "الإنعاش القلبي الرئوي",
                          subtitle: "CPR خطوات الإنعاش القلبي الرئوي",
                          normalColor: Colors.white,
                          activeColor: Color(0xFFFFE1E0),
                          iconColor: Color(0xFFB40E02),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Firstaiddetailspage11()),
                            );
                          },
                        ),
                        EmergencySectionCard(
                          icon: Icons.show_chart,
                          title: "الأزمة القلبية",
                          subtitle:
                              "التعرف على الأزمة القلبية وكيفية التعامل معها",
                          normalColor: Colors.white,
                          activeColor: Color(0xFFFDDCE7),
                          iconColor: Colors.pink,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Firstaiddetailspage12()),
                            );
                          },
                        ),
                      ],
                    ),
                  
                  const SizedBox(height: 100),
                ],
              ),
            ),
            // الأزرار الثابتة تحت (طلب الدرون ورقم الطوارئ)
            Positioned(
              bottom: 20,
              left: 15,
              right: 15,
              child: Row(
                children: [
                  // زر رقم الطوارئ
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () => _makeCall("123"),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.red, width: 2),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.phone, color: Colors.red),
                            SizedBox(width: 8),
                            Text("رقم الطوارئ", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // زر طلب الدرون
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap:() {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const DroneRequestPage()),
  );
},
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFFD90429), Color(0xFFEF233C)]),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [BoxShadow(color: Colors.red.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.airplanemode_active, color: Colors.white, size: 20),
                            Text(
                              _currentAddress == "... اضغط لطلب الموقع" ? "طلب الدرون" : "تم تحديدك",
                              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // كروت الإسعافات مع أنيميشن الرفع وتنسيق الألوان
  Widget _buildAnimatedAidCard(int index, String title, IconData icon, Color bgColor,Color iconColor , Widget page) {
    bool isHovered = _hoveredIndex == index;
   // Color iconColor = Color.lerp(bgColor, Colors.black, 0.6)!; // لون الأيقونة أغمق من الخلفية

    return GestureDetector(
      onTapDown: (_) => setState(() => _hoveredIndex = index),
      onTapUp: (_) => setState(() => _hoveredIndex = null),
      onTapCancel: () => setState(() => _hoveredIndex = null),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, isHovered ? -10 : 0, 0),
        decoration: BoxDecoration(
          color: isHovered ? bgColor : bgColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isHovered ? 0.1 : 0.05),
              blurRadius: isHovered ? 12 : 6,
              offset: Offset(0, isHovered ? 8 : 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: iconColor),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87)),
          ],
        ),
      ),
    );
  }

  // كروت أرقام الطوارئ مع الأنيميشن
Widget _buildSmallEmergencyCard(int index, String num, String label, Color color) {
  bool isHovered = _hoveredEmergencyIndex == index;

  return GestureDetector(
    onTapDown: (_) => setState(() => _hoveredEmergencyIndex = index),
    onTapUp: (_) => setState(() => _hoveredEmergencyIndex = null),
    onTapCancel: () => setState(() => _hoveredEmergencyIndex = null),
    onTap: () => _makeCall(num),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 110,
      padding: const EdgeInsets.symmetric(vertical: 12),
      transform: Matrix4.translationValues(0, isHovered ? -5 : 0, 0),
      decoration: BoxDecoration(
        color: Colors.white, // الكارت يفضل أبيض سادة زي ما طلبتي
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          // الإطار بياخد لون خفيف من لون الرقم عشان يحدد الكارت
          color: isHovered ? color : color.withOpacity(0.17), 
          width: 1.2,
        ),
        boxShadow: [
          // الظل الملون (التأثير اللي ورا الكارت)
          BoxShadow(
            color: color.withOpacity(isHovered ? 0.50 : 0.30), // الهالة الملونة
            blurRadius: isHovered ? 15 : 10, // مدى انتشار اللون ورا الكارت
            offset: const Offset(0, 4), // مكان الظل
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            num,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
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
  final VoidCallback onTap;

  const EmergencySectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.normalColor,
    required this.activeColor,
    required this.iconColor,
    required this.onTap,
    this.subtitleStyle,
  });
  final TextStyle? subtitleStyle;
  @override
  State<EmergencySectionCard> createState() => _EmergencySectionCardState();
}

class _EmergencySectionCardState extends State<EmergencySectionCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        // هنا الأنيميشن: لو مضغوط يترفع لفوق شوية ويغير لونه
        transform: Matrix4.translationValues(0, isPressed ? -5 : 0, 0),
        decoration: BoxDecoration(
          color: isPressed ? widget.activeColor : widget.normalColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isPressed ? 0.1 : 0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(
            color: isPressed ? widget.iconColor.withOpacity(0.3) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, size: 40, color: widget.iconColor),
              const SizedBox(height: 10),
              Text(
                widget.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                widget.subtitle,
                style: TextStyle(fontSize: 15, color: const Color.fromARGB(255, 95, 94, 94)),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}