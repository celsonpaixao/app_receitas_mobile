import 'package:get/get.dart';
import 'package:app_receitas_mobile/src/utils/auth/tokendecod.dart';


Future<void> setUserToken() async {
  try {
    var user = await decodeUser();
    Get.put<UserToken>(user);
  } catch (e) {
    print('Failed to set UserToken: $e');
  }
}
