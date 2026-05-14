import 'package:flutter/material.dart';
import 'package:graduation_project/features/home/presentation/home_page.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  DateTime? selectedDate;
  int? selectedGender;
  String? selectedBloodType;

  Future pickDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // اللون العنابي اللي إنتي مختاراه فوق
      backgroundColor: const Color.fromARGB(255, 156, 19, 4),
      body: Column(
        children: [
          const SizedBox(height: 200), // المسافة اللي إنتي عاملاها
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Color(0xffD3C3C3), // اللون الرمادي بتاعك
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("الأسم" ),
                    _buildInput(icon: Icons.edit),
                    const SizedBox(height: 20),
                    _buildLabel("الأيميل"),
                    _buildInput(icon: Icons.mail),
                    const SizedBox(height: 20),
                    _buildLabel("كلمة السر"),
                    _buildInput(icon: Icons.password),
                    const SizedBox(height: 20),
                    _buildLabel("رقم الهاتف"),
                    _buildInput(icon: Icons.edit),
                    const SizedBox(height: 20),
                    _buildLabel("فصيلة الدم"),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2), // نفس قوة الظل في حقولك
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                            ),
                            ],
                            ),
                            child: DropdownButtonFormField<String>(
                              value: selectedBloodType,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color.fromARGB(255, 232, 223, 223), // نفس لون حقولك
                                suffixIcon: const Icon(Icons.arrow_drop_down, color: Color.fromARGB(255, 170, 24, 14)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                  ),
                                  hint: const Text("Select Blood Type"),
                                  items: ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"]
                                  .map((label) => DropdownMenuItem(
                                    value: label,
                                    child: Text(label),
                                    ))
                                    .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedBloodType = value;
                                        }
                                        );
                                        },
                                        ),
                                        ),
                                        const SizedBox(height: 20),

// 2. حقل الحساسية (Allergies)
_buildLabel("الحساسيه"),
_buildInput(icon: Icons.warning_amber_rounded),
const SizedBox(height: 20),

// 3. حقل الأمراض المزمنة (Chronic Diseases)
_buildLabel("الأمراض المزمنه"),
_buildInput(icon: Icons.health_and_safety_rounded),
const SizedBox(height: 20),
                    _buildLabel("تاريخ الميلاد"),
                    const SizedBox(height: 8),
                    // حقل التاريخ بالتأثيرات
                    GestureDetector(
                      onTap: pickDate,
                      child: Container(
                        height: 55,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 232, 223, 223),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedDate == null
                                  ? "--/--/----"
                                  : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Icon(Icons.calendar_today, color: Color.fromARGB(255, 170, 24, 14)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    // اختيارات النوع
                    Row(
                      children: [
                        Radio<int>(
                          value: 1,
                          groupValue: selectedGender,
                          activeColor: const Color.fromARGB(255, 126, 10, 2),
                          onChanged: (v) => setState(() => selectedGender = v),
                        ),
                        const Text("male", style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20)),
                        const SizedBox(width: 40),
                        Radio<int>(
                          value: 2,
                          groupValue: selectedGender,
                          activeColor: const Color.fromARGB(255, 126, 10, 2),
                          onChanged: (v) => setState(() => selectedGender = v),
                        ),
                        const Text("female", style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20)),
                      ],
                    ),
                    const SizedBox(height: 30),
                    // --- زرار Save الاحترافي الجديد ---
                    Center(
  child: InkWell(
    onTap: () {
      // هنا كود الحفظ أو الانتقال للصفحة اللي بعدها
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    },
    borderRadius: BorderRadius.circular(100),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 65,
      width: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // تدرج ألوان احترافي (نفس ألوانك)
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
        'Save', 
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
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ميثود مساعدة لعمل الـ Label عشان الكود يبقى نضيف
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 10),
      child: Text(text, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
    );
  }

  // تعديل ميثود الـ Input عشان نضيف لها الـ Shadow
  Widget _buildInput({required IconData icon}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 232, 223, 223),
          suffixIcon: Icon(icon, color: const Color.fromARGB(255, 170, 24, 14),size: 25,),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          // 3. تأثير عند الضغط على الحقل (Focus)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 181, 45, 41), // يظهر إطار بلون الفورم لما تضغطي عليه
            width: 1,
          ),
        ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
}