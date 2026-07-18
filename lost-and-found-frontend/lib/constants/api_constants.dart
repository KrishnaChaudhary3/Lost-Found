class ApiConstants {
  // 🔧 CHANGE THIS ONE LINE depending on how you're running the app:
  //
  // Android Emulator (AVD)  → 'http://10.0.2.2:5000'
  // Real device (same WiFi) → 'http://<YOUR_PC_LOCAL_IP>:5000'  (e.g. 172.16.92.205)
  // iOS Simulator           → 'http://localhost:5000'
  //
  // This is the ONLY place the backend URL should be defined.
  static const String baseUrl = 'http://10.0.2.2:5000';

  static const String apiUrl = '$baseUrl/api';
}
