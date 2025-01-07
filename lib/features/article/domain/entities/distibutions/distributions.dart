import 'package:equatable/equatable.dart';

class Distributions extends Equatable {
  final Map<String, dynamic> native;
  final Map<String, dynamic> introduced;
  final Map<String, dynamic> doubtful;
  final Map<String, dynamic> absent;
  final Map<String, dynamic> extinct;

  const Distributions({
    required this.native,
    required this.introduced,
    required this.doubtful,
    required this.absent,
    required this.extinct,
  });

  @override
  List<Object?> get props => [native, introduced, doubtful, absent, extinct];
}
