import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProductEvent extends Equatable {
  ProductEvent([List props = const []]) : super(props);
}

class LoadProduct extends ProductEvent {
  final int productId;
  LoadProduct({
    this.productId,
  });
  @override
  String toString() => 'LoadProduct[$productId]';
}
