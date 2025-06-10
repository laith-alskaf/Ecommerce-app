import 'package:equatable/equatable.dart';

class SendCodeParams extends Equatable {
  final String code;

  const SendCodeParams({required this.code});

  @override
  List<Object?> get props => [code];
}
