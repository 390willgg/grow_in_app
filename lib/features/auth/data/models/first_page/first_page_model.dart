import 'package:hive/hive.dart';

import '../../../domain/entities/first_page/first_page.dart';

part 'first_page_model.g.dart';

@HiveType(typeId: 13)
class FirstPageModel extends FirstPage {
  const FirstPageModel({
    required super.isLoggedIn,
    required super.isEmailVerified,
  });
}
