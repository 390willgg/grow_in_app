import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'first_page.g.dart';

@HiveType(typeId: 10)
class FirstPage extends Equatable {
  @HiveField(1)
  final bool isLoggedIn;
  @HiveField(2)
  final bool isEmailVerified;

  const FirstPage({required this.isLoggedIn, required this.isEmailVerified});

  @override
  List<Object?> get props => [isLoggedIn, isEmailVerified];
}
