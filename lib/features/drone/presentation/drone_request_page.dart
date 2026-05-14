import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class DroneRequestPage extends StatefulWidget {
  const DroneRequestPage({super.key});

  @override
  State<DroneRequestPage> createState() => _DroneRequestPageState();
}

class _DroneRequestPageState extends State<DroneRequestPage> {
  // --- المتغيرات الأساسية ---
  LatLng? pickedLocation; 
  GoogleMapController? mapController;
  // المسؤول عن الكتابة داخل خانة "موقعك الحالي"
  TextEditingController locationController = TextEditingController(); 
  
  LatLng _initialPosition = const LatLng(30.0444, 31.2357);
  Set<Marker> _markers = {};

  String? selectedInjuredCount;
  String? selectedInjuryType;
  String? selectedBloodType;

  // --- دالة تحديد الموقع تلقائياً ---
  Future<void> _determinePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      pickedLocation = _initialPosition; 
      _markers = {
        Marker(
          markerId: const MarkerId("my_location"),
          position: _initialPosition,
          infoWindow: const InfoWindow(title: "موقعك الحالي"),
        ),
      };
      // ملء الخانة فوراً بالإحداثيات عند التحديد التلقائي
      locationController.text =
          "${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}";
      mapController?.animateCamera(CameraUpdate.newLatLng(_initialPosition));
    });
  }

  // --- تصميم قسم الخريطة مع زرار التأكيد ---
  Widget _buildMapSection() {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _initialPosition, zoom: 15),
              onMapCreated: (controller) => mapController = controller,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              markers: _markers,
              onTap: (LatLng position) {
                setState(() {
                  pickedLocation = position;
                  _markers = {
                    Marker(
                      markerId: const MarkerId("selected_location"),
                      position: position,
                    )
                  };
                });
              },
            ),
            // زرار التأكيد الأحمر العايم فوق الخريطة
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: ElevatedButton(
                onPressed: () {
                  if (pickedLocation != null) {
                    setState(() {
                      // نقل الإحداثيات من الخريطة للخانة اللي تحت
                      locationController.text =
                          "${pickedLocation!.latitude.toStringAsFixed(4)}, ${pickedLocation!.longitude.toStringAsFixed(4)}";
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("تم تحديد موقع الاستغاثة بنجاح!",
                            textAlign: TextAlign.center),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD11212),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("تأكيد هذا الموقع",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- تصميم حقل الإدخال الموحد (مع خاصية القراءة فقط) ---
  Widget _buildModernTextField({
    required String hint,
    required IconData icon,
    TextEditingController? controller,
    bool readOnly = false,
  }) {
    return Focus(
      child: Builder(
        builder: (context) {
          final bool isFocused = Focus.of(context).hasFocus;
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: isFocused
                        ? const Color.fromARGB(255, 209, 18, 18).withOpacity(0.3)
                        : Colors.black.withOpacity(0.2),
                    blurRadius: isFocused ? 15 : 10,
                    offset: isFocused ? const Offset(0, 6) : const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: controller,
                readOnly: readOnly,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 14),
                  prefixIcon: Icon(icon,
                      color: const Color.fromARGB(255, 209, 18, 18)),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // --- تصميم الـ Dropdown ---
  Widget _buildModernDropdown({
    required String hint,
    required IconData icon,
    required List<String> items,
    required String? value,
    required Function(String?) onChanged,
  }) {
    return Focus(
      child: Builder(builder: (context) {
        final bool isFocused = Focus.of(context).hasFocus;
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: isFocused
                      ? const Color.fromARGB(255, 209, 18, 18).withOpacity(0.3)
                      : Colors.black.withOpacity(0.2),
                  blurRadius: isFocused ? 15 : 10,
                  offset: isFocused ? const Offset(0, 6) : const Offset(0, 4),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                value: value,
                decoration: InputDecoration(
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Icon(icon, color: const Color(0xFFD11212)),
                  ),
                  hintText: hint,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Align(
                        alignment: Alignment.centerRight, child: Text(item)),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        );
      }),
    );
  }

  // --- زرار إرسال الطلب النهائي ---
  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xFFD11212), Color(0xFF910C0C)]),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFFD11212).withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6))
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          // هنا هيتم الربط مع الفايربيز لاحقاً
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        child: const Text("تأكيد وإرسال الطلب",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFBFBFB),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 171, 16, 16),
          title: const Text("طلب الدرون",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            children: [
              _buildMapSection(),
              const SizedBox(height: 15),
              TextButton.icon(
                onPressed: _determinePosition,
                icon: const Icon(Icons.gps_fixed,
                    color: Color.fromARGB(255, 209, 18, 18)),
                label: const Text("تحديد موقعي الحالي تلقائياً",
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 25),
              // حقل الموقع مربوط بالكونترولر ومقفول للكتابة اليدوية
              _buildModernTextField(
                hint: "موقعك الحالي",
                icon: Icons.map_outlined,
                controller: locationController,
                readOnly: true,
              ),
              _buildModernDropdown(
                hint: "عدد المصابين",
                icon: Icons.group_add_outlined,
                items: ["1", "2", "3", "4", "100+"],
                value: selectedInjuredCount,
                onChanged: (val) => setState(() => selectedInjuredCount = val),
              ),
              _buildModernDropdown(
                hint: "نوع الإصابة",
                icon: Icons.medical_services,
                items: ["حروق", "كسور", "جروح", "اختناق", "أزمة قلبية", "صدمة", "تسمم", "غيبوبة السكر", "اصابة عين", "ضربة شمس"],
                value: selectedInjuryType,
                onChanged: (val) => setState(() => selectedInjuryType = val),
              ),
              _buildModernDropdown(
                hint: "فصيلة الدم ",
                icon: Icons.bloodtype_outlined,
                items: ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-" , "لا أعلم"],
                value: selectedBloodType,
                onChanged: (val) => setState(() => selectedBloodType = val),
              ),
              _buildModernTextField(
                hint: "هل يوجد حساسية من أدوية معينة؟",
                icon: Icons.announcement_outlined,
              ),
              _buildModernTextField(
                hint: "ملاحظات إضافية",
                icon: Icons.note_add_outlined,
              ),
              const SizedBox(height: 10),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}