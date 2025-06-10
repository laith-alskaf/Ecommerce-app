import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_e_commerce/core/error/failure.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  const NoParams(); // Added const constructor

  @override
  List<Object?> get props => [];
}