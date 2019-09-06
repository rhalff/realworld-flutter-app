part of catalog.blocs;

@immutable
abstract class ProductsState extends Equatable {
  ProductsState([List props = const []]) : super(props);
}

class ProductsLoading extends ProductsState {
  @override
  String toString() => 'ProductsLoading';
}

class ProductsLoaded extends ProductsState {
  final List<Product> products;

  ProductsLoaded(this.products) : super([products]);

  @override
  String toString() {
    return 'ProductsLoaded[products: $products]';
  }
}

class ProductsError extends ProductsState {
  final String error;

  ProductsError(this.error) : super([error]);

  @override
  String toString() => 'ProductsError[error: $error]';
}
