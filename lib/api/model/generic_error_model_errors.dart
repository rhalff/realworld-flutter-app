import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'generic_error_model_errors.jser.dart';

class GenericErrorModelErrors {
  @Alias('body', isNullable: false)
  final List<String> body;

  GenericErrorModelErrors({this.body = const []});

  @override
  String toString() {
    return 'GenericErrorModelErrors[body=$body, ]';
  }
}

@GenSerializer(nullableFields: true)
class GenericErrorModelErrorsSerializer
    extends Serializer<GenericErrorModelErrors>
    with _$GenericErrorModelErrorsSerializer {}
