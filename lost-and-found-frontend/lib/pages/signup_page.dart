// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SignUpPage extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmController = TextEditingController();
//
//   Future<void> _signUp(BuildContext context) async {
//     final email = emailController.text.trim();
//     final password = passwordController.text;
//     final confirm = confirmController.text;
//
//     if (password != confirm) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Passwords do not match")),
//       );
//       return;
//     }
//
//     final url = Uri.parse('http://10.68.88.51:5000/api/auth/signup');
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode({'email': email, 'password': password}),
//     );
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('token', data['token']);
//
//       Navigator.pushReplacementNamed(context, '/home');
//     } else {
//       final error = json.decode(response.body);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(error['message'] ?? 'Signup failed')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0),
//         child: Center(
//           child: SingleChildScrollView( // ✅ Prevents red overflow lines
//             child: Column(
//               children: [
//                 Icon(Icons.person_add, size: 80, color: Colors.teal),
//                 SizedBox(height: 20),
//                 Text("Create Account", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                 SizedBox(height: 30),
//                 TextField(
//                   controller: emailController,
//                   decoration: InputDecoration(labelText: 'Email'),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(labelText: 'Password'),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: confirmController,
//                   obscureText: true,
//                   decoration: InputDecoration(labelText: 'Confirm Password'),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () => _signUp(context), // ✅ Hooked here
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.teal,
//                     padding: EdgeInsets.symmetric(horizontal: 60, vertical: 14),
//                   ),
//                   child: Text("Sign Up"),
//                 ),
//                 SizedBox(height: 20),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text("Already have an account? Login"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView( // ✅ Prevents red overflow lines
            child: Column(
              children: [
                Icon(Icons.person_add, size: 80, color: Colors.teal),
                SizedBox(height: 20),
                Text("Create Account", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 30),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: confirmController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                  ),
                  child: Text("Sign Up"),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Already have an account? Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
//
//
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // class SignUpPage extends StatelessWidget {
// //   final TextEditingController emailController = TextEditingController();
// //   final TextEditingController passwordController = TextEditingController();
// //   final TextEditingController confirmController = TextEditingController();
// //
// //   Future<void> _signUp(BuildContext context) async {
// //     final email = emailController.text;
// //     final password = passwordController.text;
// //     final confirm = confirmController.text;
// //
// //     if (password != confirm) {
// //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Passwords do not match")));
// //       return;
// //     }
// //
// //     final url = Uri.parse('http://10.68.88.51:5000/api/users/signup');
// //     final response = await http.post(
// //       url,
// //       headers: {'Content-Type': 'application/json'},
// //       body: json.encode({'email': email, 'password': password}),
// //     );
// //
// //     if (response.statusCode == 200) {
// //       final data = json.decode(response.body);
// //       final prefs = await SharedPreferences.getInstance();
// //       await prefs.setString('token', data['token']); // store token
// //
// //       Navigator.pushReplacementNamed(context, '/home');
// //     } else {
// //       final error = json.decode(response.body);
// //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error['message'] ?? 'Signup failed')));
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Padding(
// //         padding: const EdgeInsets.symmetric(horizontal: 24.0),
// //         child: Center(
// //           child: SingleChildScrollView(
// //             child: Column(
// //               children: [
// //                 Icon(Icons.person_add, size: 80, color: Colors.teal),
// //                 SizedBox(height: 20),
// //                 Text("Create Account", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
// //                 SizedBox(height: 30),
// //                 TextField(
// //                   controller: emailController,
// //                   decoration: InputDecoration(labelText: 'Email'),
// //                 ),
// //                 SizedBox(height: 10),
// //                 TextField(
// //                   controller: passwordController,
// //                   obscureText: true,
// //                   decoration: InputDecoration(labelText: 'Password'),
// //                 ),
// //                 SizedBox(height: 10),
// //                 TextField(
// //                   controller: confirmController,
// //                   obscureText: true,
// //                   decoration: InputDecoration(labelText: 'Confirm Password'),
// //                 ),
// //                 SizedBox(height: 20),
// //                 ElevatedButton(
// //                   onPressed: () => _signUp(context),
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.teal,
// //                     padding: EdgeInsets.symmetric(horizontal: 60, vertical: 14),
// //                   ),
// //                   child: Text("Sign Up"),
// //                 ),
// //                 SizedBox(height: 20),
// //                 TextButton(
// //                   onPressed: () {
// //                     Navigator.pop(context);
// //                   },
// //                   child: Text("Already have an account? Login"),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
