import 'package:flutter_riverpod/flutter_riverpod.dart';

final verificationIdProvider = StateProvider((ref) {
  return "";
});

final resendTokenProvider = StateProvider<int>((ref) {
  return 0;
});
