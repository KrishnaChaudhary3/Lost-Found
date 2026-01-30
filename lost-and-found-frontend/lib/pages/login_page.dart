// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class LoginPage extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   Future<void> loginUser(BuildContext context) async {
//     final email = emailController.text.trim();
//     final password = passwordController.text.trim();
//
//     final url = Uri.parse('http://10.68.88.51:5000/api/auth/login'); // ✅ Adjust IP if needed
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'email': email, 'password': password}),
//     );
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       print('✅ Login successful: ${data['token']}');
//       Navigator.pushReplacementNamed(context, '/home');
//     } else {
//       final data = jsonDecode(response.body);
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: Text("Login Failed"),
//           content: Text(data['message'] ?? 'Something went wrong'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text("OK"),
//             ),
//           ],
//         ),
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
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.lock, size: 80, color: Colors.teal),
//                 SizedBox(height: 20),
//                 Text("Welcome Back", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/forgot');
//                     },
//                     child: Text("Forgot Password?"),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () => loginUser(context),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.teal,
//                     padding: EdgeInsets.symmetric(horizontal: 80, vertical: 14),
//                   ),
//                   child: Text("Login"),
//                 ),
//                 SizedBox(height: 20),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/signup');
//                   },
//                   child: Text("Don't have an account? Sign Up"),
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
import 'package:http/http.dart' as http;
import 'dart:convert';


class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView( // ✅ No overflow!
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock, size: 80, color: Colors.teal),
                SizedBox(height: 20),
                Text("Welcome Back", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgot');
                    },
                    child: Text("Forgot Password?"),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 14),
                  ),
                  child: Text("Login"),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text("Don't have an account? Sign Up"),
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
// //
// // class LoginPage extends StatelessWidget {
// //   final TextEditingController emailController = TextEditingController();
// //   final TextEditingController passwordController = TextEditingController();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Padding(
// //         padding: const EdgeInsets.symmetric(horizontal: 24.0),
// //         child: Center(
// //           child: SingleChildScrollView(
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Icon(Icons.lock, size: 80, color: Colors.teal),
// //                 SizedBox(height: 20),
// //                 Text("Welcome Back", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
// //                 Align(
// //                   alignment: Alignment.centerRight,
// //                   child: TextButton(
// //                     onPressed: () {
// //                       Navigator.pushNamed(context, '/forgot');
// //                     },
// //                     child: Text("Forgot Password?"),
// //                   ),
// //                 ),
// //                 SizedBox(height: 20),
// //                 ElevatedButton(
// //                   onPressed: () async {
// //                     final email = emailController.text.trim();
// //                     final password = passwordController.text.trim();
// //
// //                     final response = await http.post(
// //                       Uri.parse('http://10.68.88.51:5000/api/login'),
// //                       headers: {'Content-Type': 'application/json'},
// //                       body: jsonEncode({'email': email, 'password': password}),
// //                     );
// //
// //                     if (response.statusCode == 200) {
// //                       final data = jsonDecode(response.body);
// //                       print('Login successful: ${data['token']}');
// //                       Navigator.pushReplacementNamed(context, '/home');
// //                     } else {
// //                       final data = jsonDecode(response.body);
// //                       showDialog(
// //                         context: context,
// //                         builder: (_) => AlertDialog(
// //                           title: Text("Login Failed"),
// //                           content: Text(data['message']),
// //                           actions: [
// //                             TextButton(
// //                               onPressed: () => Navigator.pop(context),
// //                               child: Text("OK"),
// //                             ),
// //                           ],
// //                         ),
// //                       );
// //                     }
// //                   },
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.teal,
// //                     padding: EdgeInsets.symmetric(horizontal: 80, vertical: 14),
// //                   ),
// //                   child: Text("Login"),
// //                 ),
// //                 SizedBox(height: 20),
// //                 TextButton(
// //                   onPressed: () {
// //                     Navigator.pushNamed(context, '/signup');
// //                   },
// //                   child: Text("Don't have an account? Sign Up"),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
