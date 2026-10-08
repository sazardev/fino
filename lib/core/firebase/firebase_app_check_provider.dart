import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_app_check_provider.g.dart';

@Riverpod(keepAlive: true)
FirebaseAppCheck firebaseAppCheck(Ref ref) => FirebaseAppCheck.instance;
