part of catalog.blocs;

@immutable
abstract class ProductsEvent extends Equatable {
  ProductsEvent([List props = const []]) : super(props);
}

class LoadProducts extends ProductsEvent {
  final int departmentId;
  final int categoryId;
  LoadProducts({
    this.departmentId,
    this.categoryId,
  });
  @override
  String toString() =>
      'LoadProducts[departmentId: $departmentId, categoryId: $categoryId]';
}
