import 'package:firebase_performance/firebase_performance.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_performance_provider.g.dart';

@Riverpod(keepAlive: true)
FirebasePerformance firebasePerformance(Ref ref) =>
    FirebasePerformance.instance;
