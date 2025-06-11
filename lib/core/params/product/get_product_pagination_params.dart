import 'package:equatable/equatable.dart';

class GetProductPaginationParams extends Equatable {
  final int page;
  final int limit;
  final String title;

  const GetProductPaginationParams({
    this.page = 1,
    this.limit = 10,
    this.title = '',
  });

  @override
  List<Object?> get props => [page, limit];
}
