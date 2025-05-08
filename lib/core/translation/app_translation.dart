import 'package:get/get.dart';
import 'package:simple_e_commerce/core/translation/languages/ar_language.dart';
import 'package:simple_e_commerce/core/translation/languages/en_language.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": EnLanguage.map,
        "ar_SA": ARLanguage.map,
      };
}

tr(String key) => key.tr;
