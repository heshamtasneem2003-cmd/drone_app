import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // متغير عشان نخزن رقم الكارت اللي دوسنا عليه حالياً
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 244, 67, 54),
        child: const Icon(Icons.call, color: Colors.white, size: 30),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- الجزء العلوي (البحث) ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 25),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 224, 55, 43),
                //Color(0xff76545D),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(Icons.menu, color: Colors.white),
                      Text("الإسعافات الأولية", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      Icon(Icons.notifications_none, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: "ابحث عن نوع الإصابة",
                      hintStyle: const TextStyle(color: Colors.white70),
                      prefixIcon: const Icon(Icons.search, color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                    ),
                  ),
                ],
              ),
            ),

            // --- زر طوارئ SOS ---
            Transform.translate(
              offset: const Offset(0, -15),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 244, 67, 54),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 1.2),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.location_on, color: Colors.black, size: 35),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text("SOS - طوارئ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("ارسال الموقع واستدعاء الدرون للمساعدة", style: TextStyle(fontSize: 12, color: Colors.black87)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // --- أرقام الطوارئ ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildEmergencyCard("180", "المطافي", Colors.orange),
                  _buildEmergencyCard("122", "النجدة", Colors.blue),
                  _buildEmergencyCard("123", "الإسعاف", Colors.red),
                ],
              ),
            ),

            const SizedBox(height: 25),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text("دليل الإسعافات الأولية", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),

            // --- Grid الإسعافات (التعديل الجديد هنا) ---
            Padding(
              padding: const EdgeInsets.all(20),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.0, // جعل الكارت مربع عشان الأيقونة تتوسطه
                children: [
                  _buildAidCard(0, "الكسور", Icons.medication_outlined, const Color.fromARGB(255, 152, 187, 211)), // أزرق فاتح),
                  _buildAidCard(1, "الجروح", Icons.healing_outlined, const Color.fromARGB(255, 212, 160, 168)),   // أحمر فاتح),
                  _buildAidCard(2, "الحروق", Icons.whatshot_outlined, const Color.fromARGB(255, 227, 192, 136)),  // برتقالي فاتح),
                  _buildAidCard(3, "الاختناق", Icons.air_outlined, const Color.fromARGB(255, 160, 207, 161)),
                  _buildAidCard(4, "الصدمة", Icons.psychology_outlined, const Color.fromARGB(255, 208, 169, 214)),
                  _buildAidCard(5, "التسمم", Icons.warning_amber_outlined, const Color.fromARGB(255, 246, 235, 142)),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  // ودجت كروت الإسعافات مع تأثير اللمس وتغيير اللون
  Widget _buildAidCard(int index, String title, IconData iconData, Color activeColor) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index; // تغيير الحالة عند الضغط
        });
      },
      child: Container(
        decoration: BoxDecoration(
          // اللون يتغير لو دوسنا عليه، وإلا يفضل أبيض
          color: isSelected ? activeColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 0.8),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 5, offset: const Offset(0, 3))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // توسيط المحتوى عمودياً
          children: [
            Icon(
              iconData,
              size: 45,
              color: isSelected ? Colors.black87 : const Color(0xff76545D),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isSelected ? Colors.black : Colors.black87,
              ),
            ),
            if (isSelected)
              const Text(
                "اقرأ المزيد >",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyCard(String number, String label, Color color) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.5), width: 1),
        boxShadow: [BoxShadow(color: color.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Text(number, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}