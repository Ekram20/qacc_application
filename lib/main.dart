import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/providers/employee_provider.dart';
import 'package:qacc_application/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // لا نظهر إشعار يدويًا هنا لأن النظام يعرضه تلقائيًا
  print("🔔 رسالة في الخلفية: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  const initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  );

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'default_channel', // لازم يكون نفس الموجود في كود الإشعار
  'Default Channel',
  description: 'This channel is used for important notifications.',
  importance: Importance.max, // أهمية عالية عشان يظهر الإشعار
  playSound: true,
);

await flutterLocalNotificationsPlugin
    .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
    ?.createNotificationChannel(channel);


  await flutterLocalNotificationsPlugin.initialize(initializationSettings);




  runApp(MultiProvider(
    providers: [
              ChangeNotifierProvider(create: (_) => EmployeeProvider()),

    ],
 child: const MyApp(),
    
  ));
}


void _showNotification(RemoteMessage message) async {
  final notification = message.notification;
  final android = message.notification?.android;

  if (notification != null && android != null) {
    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default Channel',
      channelDescription: 'Used for important notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const platformDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      platformDetails,
    );
  }
}

/* void _showNotification(RemoteMessage message) async {
  final notification = message.notification;
  final android = message.notification?.android;

  if (notification != null && android != null) {
    const androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Channel',
      channelDescription: 'Used for important notifications',
      importance: Importance.high, // أهمية عالية
      priority: Priority.high, // أولوية عالية
    );
    const platformDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      platformDetails,
    );
  }
} */

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

    @override
  void initState() {
    super.initState();
    _setupFCM();
  }

  void _setupFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('🔐 إذن المستخدم: ${settings.authorizationStatus}');

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleMessage(message);
      }
    });

    // نظهر إشعار فقط إذا كان التطبيق مفتوحًا
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessage(message);
    });
  }

  void _handleMessage(RemoteMessage message) {
    print("📬 تم فتح التطبيق من إشعار: ${message.notification?.title}");
    // يمكن التنقل لصفحة معينة هنا حسب محتوى الرسالة
  }


  @override
  Widget build(BuildContext context) {
    AppRouter appRouter = AppRouter();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme:  TextSelectionThemeData(
          selectionColor: AppColors.primaryColor.shade50, // ✅ لون التحديد الذهبي
          selectionHandleColor: AppColors.primaryColor.shade50, // ✅ لون المقبض عند تعديل التحديد
          cursorColor: AppColors.primaryColor.shade50, // ✅ لون المؤشر الذهبي
        ),
        scaffoldBackgroundColor: AppColors.backgroundColor,
        fontFamily: '',
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: 20,
            color: AppColors.secondaryColor.shade900,
            fontFamily: 'Cairo',
          ),
          headlineMedium: TextStyle(
            fontSize: 18,
            color: AppColors.secondaryColor.shade500,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
          headlineSmall: TextStyle(
            fontSize: 16,
            color: AppColors.secondaryColor.shade500,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            fontSize: 20,
            color: AppColors.secondaryColor.shade900,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ), // نص كبير
          bodyMedium: TextStyle(
            fontSize: 16,
            color: AppColors.secondaryColor.shade500,
            fontFamily: 'Cairo',
          ), // نص متوسط
          bodySmall: TextStyle(
            fontSize: 16,
            color: AppColors.white,
            fontFamily: 'Cairo',
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.appBarColor, // لون شريط التطبيق
          elevation: 0, // إخفاء الظل
        ),
        popupMenuTheme: PopupMenuThemeData(
          color: AppColors.white, // لون خلفية القائمة
          textStyle:
              TextStyle(color: AppColors.textColor), // لون النصوص داخل القائمة
        ),
      ),
      routerConfig: appRouter.config(),
    );
  }
}
