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
      backgroundColor: const Color(0xff76545D), 
      body: Column(
        children: [
          const SizedBox(height: 200), 

          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Color(0xffD3C3C3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Name", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _buildInput(icon: Icons.edit),
                    const SizedBox(height: 20),

                    const Text("Email", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _buildInput(icon: Icons.mail),
                    const SizedBox(height: 20),

                    const Text("Password", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _buildInput(icon: Icons.password),
                    const SizedBox(height: 20),

                    const Text("Phone", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _buildInput(icon: Icons.edit),
                    const SizedBox(height: 20),

                    const Text("Date of birthday", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),

                    GestureDetector(
                      onTap: pickDate,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          color: const Color(0xffFDEAEA),
                          borderRadius: BorderRadius.circular(30),
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
                            const Icon(Icons.calendar_today, color: Color(0xff76545D)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    Row(
                      children: [
                        Radio<int>(
                          value: 1,
                          groupValue: selectedGender,
                          activeColor: const Color(0xff76545D),
                          onChanged: (v) {
                            setState(() {
                              selectedGender = v;
                            });
                          },
                        ),
                        const Text("male"),
                        const SizedBox(width: 40),
                        Radio<int>(
                          value: 2,
                          groupValue: selectedGender,
                          activeColor: const Color(0xff76545D),
                          onChanged: (v) {
                            setState(() {
                              selectedGender = v;
                            });
                          },
                        ),
                        const Text("female"),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // بيودي لصفحة الهوم الجديدة
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const HomePage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffF4BBBB),
                          foregroundColor: Colors.black,
                          minimumSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: const Text("Save", style: TextStyle(fontSize: 20)),
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

  Widget _buildInput({required IconData icon}) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffFDEAEA),
        suffixIcon: Icon(icon, color: const Color(0xff76545D)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}