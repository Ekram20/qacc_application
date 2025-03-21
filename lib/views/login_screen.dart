import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:animate_do/animate_do.dart';
import 'package:qacc_application/providers/employee_provider.dart';
import 'package:qacc_application/router/app_router.gr.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // تسجيل الدخول عبر Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // 1️⃣ بدء تسجيل الدخول باستخدام Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null; // المستخدم ألغى العملية

      // 2️⃣ الحصول على بيانات المصادقة
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // 3️⃣ إنشاء بيانات اعتماد Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4️⃣ تسجيل الدخول باستخدام Firebase
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential;
    } catch (e) {
      print("❌ حدث خطأ: $e");
      return null;
    }
  }

// التحقق من البريد الإلكتروني في قاعدة البيانات واسترجاع بيانات الموظف
Future<Map<String, dynamic>?> checkEmployeeEmail(String email) async {
  final response = await http.post(
    Uri.parse('https://hr.qacc.ly/php/check_employee_email.php'),
    body: {'email': email},
  );

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);

    if (data['exists'] == true) {
      return data['employee']; // إرجاع بيانات الموظف فقط
    }
  }

  return null; // إرجاع null إذا لم يكن الموظف موجودًا
}


  // تنفيذ تسجيل الدخول
void handleSignIn() async {
  UserCredential? userCredential = await signInWithGoogle();
  if (userCredential != null) {
    String email = userCredential.user!.email!;
    print("✅ تسجيل دخول ناجح: $email");

    Map<String, dynamic>? employeeData = await checkEmployeeEmail(email);

    if (employeeData != null) {
      // حفظ بيانات الموظف في EmployeeProvider
      Provider.of<EmployeeProvider>(context, listen: false)
          .setEmployeeData(employeeData);

      // الانتقال إلى الصفحة الرئيسية
      context.router.replace(BottomNavigationBarEmployees());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("ليس لديك صلاحية الدخول، يرجى مراجعة شؤون الموظفين",textAlign: TextAlign.right,),
          backgroundColor: Colors.red,
        ),
      );
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
    }
  }
}

/*   // تنفيذ تسجيل الدخول
  void handleSignIn() async {
    UserCredential? userCredential = await signInWithGoogle();
    if (userCredential != null) {
      String email = userCredential.user!.email!; // الحصول على الإيميل
      print("✅ تسجيل دخول ناجح: $email");

      // الانتقال إلى الشاشة الرئيسية بعد نجاح المصادقة
      context.router.replace(BottomNavigationBarEmployees(email: email));
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.secondaryColor.shade900,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            //begin: Alignment.topLeft,
            //end: Alignment.bottomRight,
            colors: [
              AppColors.secondaryColor.shade900, // لون داكن في الأعلى
              AppColors.secondaryColor.shade500, // لون أفتح في المنتصف
              AppColors.secondaryColor.shade900, // لون فاتح في الأسفل
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -50,
              right: -50,
              child: Opacity(
                opacity: 0.1,
                child: BounceInDown(
                  duration: Duration(seconds: 2),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 650,
                    width: 700,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BounceInDown(
                      duration: Duration(seconds: 2),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 250,
                        width: 250,
                      ),
                    ),
                    Gap(10.0),
                    FadeInUp(
                      duration: Duration(seconds: 2),
                      child: Text(
                        "!مرحبًا بك",
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                    Gap(10),
                    FadeInUp(
                      duration: Duration(seconds: 2),
                      child: Text(
                        "قم بتسجيل الدخول للمتابعة",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white70,
                            ),
                      ),
                    ),
                    Gap(30),
                    FadeInUp(
                      duration: Duration(seconds: 2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor.shade700,
                          borderRadius: BorderRadius.circular(50.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed: handleSignIn,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Google تسجيل الدخول باستخدام",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Gap(15.0),
                                Image.asset(
                                  'assets/images/google-logo.png',
                                  height: 24,
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "© 2025 جميع الحقوق محفوظة",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                    ),
                    Text(
                      "® م. إكرام العرضاوي ®  |  م. رحمة سعيد",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
