part of catalog.blocs;

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository productRepository;

  ProductsBloc({
    @required this.productRepository,
  }) : assert(productRepository != null);

  @override
  ProductsState get initialState => ProductsLoading();

  @override
  Stream<ProductsState> mapEventToState(ProductsEvent event) async* {
    if (event is LoadProducts) {
      yield* _loadProducts(event);
    }
  }

  Stream<ProductsState> _loadProducts(LoadProducts event) async* {
    yield ProductsLoading();

    try {
      List<Product> products;
      if (event.departmentId != null) {
        products = await productRepository.getProductsByDepartmentId(
            departmentId: event.departmentId);
      } else if (event.categoryId != null) {
        products = await productRepository.getProductsByCategoryId(
            categoryId: event.categoryId);
      } else {
        products = await productRepository.getProducts();
      }

      yield ProductsLoaded(products);
    } catch (error) {
      print(error);
      yield ProductsError('Failed to load products');
    }
  }
}
