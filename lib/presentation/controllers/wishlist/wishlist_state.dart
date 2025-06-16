import 'package:equatable/equatable.dart';
import 'package:simple_e_commerce/domain/entities/product_entity.dart';

abstract class WishlistState extends Equatable {
  final List<ProductEntity> wishlistItems;
  final String message;

  const WishlistState({this.wishlistItems = const [], this.message = ''});

  @override
  List<Object?> get props => [wishlistItems, message];
}

// Get Wishlist
class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  const WishlistLoaded({super.wishlistItems});

  @override
  List<Object?> get props => [wishlistItems];
}

class WishlistError extends WishlistState {
  const WishlistError({required super.message});

  @override
  List<Object?> get props => [message];
}

// Add Product
class AddProductLoading extends WishlistState {
  const AddProductLoading({super.wishlistItems});
}

class AddProductSuccess extends WishlistState {
  const AddProductSuccess({super.wishlistItems, required super.message});

  @override
  List<Object?> get props => [wishlistItems];
}

class AddProductError extends WishlistState {
  const AddProductError({super.wishlistItems, required super.message});
}

// Remove Product

class RemoveProductLoading extends WishlistState {
  const RemoveProductLoading({super.wishlistItems});
}

class RemoveProductSuccess extends WishlistState {
  const RemoveProductSuccess({super.wishlistItems, required super.message});

  @override
  List<Object?> get props => [wishlistItems];
}

class RemoveProductError extends WishlistState {
  const RemoveProductError({super.wishlistItems, required super.message});
}
// Remove All Products

class RemoveAllProductsLoading extends WishlistState {
  const RemoveAllProductsLoading({super.wishlistItems});
}

class RemoveAllProductsSuccess extends WishlistState {
  const RemoveAllProductsSuccess({super.wishlistItems, required super.message});

  @override
  List<Object?> get props => [wishlistItems];
}

class RemoveAllProductsError extends WishlistState {
  const RemoveAllProductsError({super.wishlistItems, required super.message});
}
